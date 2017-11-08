USE BelcorpPeru
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.ConsultarOfertaByCUV
@CampaniaID		  INT,
@CUV2			  VARCHAR(20),
@TipoEstrategiaID INT,
@CUV1			  VARCHAR(20),
@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
	SET NOCOUNT ON;

	DECLARE @FlagNueva INT, 
			@FlagRecoProduc INT, 
			@FlagRecoPerfil INT, 
			@FlagOferta INT,
			@codigoSAP VARCHAR(20) = NULL,
			@numeroTallas INT,
			@codigoEstrategia VARCHAR(5) = ''

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			/*IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END*/
			SET @FlagOferta = -1

			SELECT 
				@FlagNueva = FlagNueva, 
				@FlagRecoProduc = FlagRecoProduc, 
				@FlagRecoPerfil = FlagRecoPerfil 
			FROM dbo.TipoEstrategia (NOLOCK)
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2

			/*WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;*/
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK)
				ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc (NOLOCK)
			INNER JOIN ods.Campania c (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID 
			AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial (NOLOCK) WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CodigoProducto = @codigoSAP 
			AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			SELECT @numeroTallas = COUNT(1) 
			FROM dbo.TallaColorCUV (NOLOCK) 
			WHERE CampaniaID = @CampaniaID 
			AND CUVPadre = @CUV2;

			IF @numeroTallas = 1
			BEGIN
				DELETE FROM dbo.TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM dbo.TallaColorCUV (NOLOCK)
				WHERE CampaniaID = @CampaniaID 
				AND CUVPadre = @CUV2 
				AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END
		END
		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			SET @codigoEstrategia = CASE @flag 
										WHEN 4 THEN 'ODD'
										WHEN 9 THEN 'LAN'
										WHEN 10 THEN 'OPM'
										WHEN 11 THEN 'PAD'
									END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC (NOLOCK)
				INNER JOIN ods.Campania C (NOLOCK) 
				ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID 
				AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ods.ProductoComercial PC (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE C.CODIGO = @CampaniaID 
			AND PC.CUV = @CUV2;
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT 
				DescripcionCUV2,
				Precio2 PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM dbo.Estrategia E (NOLOCK)
			INNER JOIN ods.Campania C (NOLOCK)
			ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ods.ProductoComercial PC (NOLOCK)
			ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN dbo.MatrizComercial MC (NOLOCK)
			ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO

