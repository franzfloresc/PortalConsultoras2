

USE BelcorpColombia
GO

ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			IF NOT EXISTS(
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
			END

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
				END
			END

			DECLARE @FlagNueva INT, @FlagRecoProduc INT, @FlagRecoPerfil INT, @FlagOferta INT
			SET @FlagOferta = -1

			SELECT @FlagNueva = FlagNueva, @FlagRecoProduc = FlagRecoProduc, @FlagRecoPerfil = FlagRecoPerfil 
			FROM TipoEstrategia 
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campa�a actual.', 16, 1)
			END

			DECLARE @codigoSAP VARCHAR(20) = NULL;
			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc
			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
				RAISERROR('El CUV1 no pertenece al mismo c�digo SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'' FotoProducto01,
				'' FotoProducto02,
				'' FotoProducto03,
				'' FotoProducto04,
				'' FotoProducto05,
				'' FotoProducto06,
				'' FotoProducto07,
				'' FotoProducto08,
				'' FotoProducto09,
				'' FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.CODIGO = @CampaniaID AND PC.CodigoProducto = @codigoSAP AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			DECLARE @numeroTallas INT = (SELECT COUNT(1) FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2);
			IF @numeroTallas = 1
			BEGIN
				DELETE FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10
				FROM TallaColorCUV
				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10;
			END
		END
		
		ELSE IF @flag = 4
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				--CODIGOTIPOOFERTA IN (
				--	SELECT CODIGOOFERTA
				--	FROM TIPOESTRATEGIAOFERTA TE
				--	INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
				--	WHERE TIPOESTRATEGIAID = @TipoEstrategiaID ---OR 0 = @FlagOferta
				--)
				--AND 
				
				C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END

GO

/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			IF NOT EXISTS(
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
			END

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
				END
			END

			DECLARE @FlagNueva INT, @FlagRecoProduc INT, @FlagRecoPerfil INT, @FlagOferta INT
			SET @FlagOferta = -1

			SELECT @FlagNueva = FlagNueva, @FlagRecoProduc = FlagRecoProduc, @FlagRecoPerfil = FlagRecoPerfil 
			FROM TipoEstrategia 
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campa�a actual.', 16, 1)
			END

			DECLARE @codigoSAP VARCHAR(20) = NULL;
			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc
			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
				RAISERROR('El CUV1 no pertenece al mismo c�digo SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'' FotoProducto01,
				'' FotoProducto02,
				'' FotoProducto03,
				'' FotoProducto04,
				'' FotoProducto05,
				'' FotoProducto06,
				'' FotoProducto07,
				'' FotoProducto08,
				'' FotoProducto09,
				'' FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.CODIGO = @CampaniaID AND PC.CodigoProducto = @codigoSAP AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			DECLARE @numeroTallas INT = (SELECT COUNT(1) FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2);
			IF @numeroTallas = 1
			BEGIN
				DELETE FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10
				FROM TallaColorCUV
				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10;
			END
		END
		
		ELSE IF @flag = 4
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				--CODIGOTIPOOFERTA IN (
				--	SELECT CODIGOOFERTA
				--	FROM TIPOESTRATEGIAOFERTA TE
				--	INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
				--	WHERE TIPOESTRATEGIAID = @TipoEstrategiaID ---OR 0 = @FlagOferta
				--)
				--AND 
				
				C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END

GO

/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripci�n vac�a }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF @flag = 0 OR @flag = 2
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			IF NOT EXISTS(
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
			END

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
				END
			END

			DECLARE @FlagNueva INT, @FlagRecoProduc INT, @FlagRecoPerfil INT, @FlagOferta INT
			SET @FlagOferta = -1

			SELECT @FlagNueva = FlagNueva, @FlagRecoProduc = FlagRecoProduc, @FlagRecoPerfil = FlagRecoPerfil 
			FROM TipoEstrategia 
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'
				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
		ELSE IF @flag = 1
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV1
			)
			BEGIN
				RAISERROR('El CUV1 ingresado no existe para la campa�a actual.', 16, 1)
			END

			DECLARE @codigoSAP VARCHAR(20) = NULL;
			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc
			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
				RAISERROR('El CUV1 no pertenece al mismo c�digo SAP que el CUV2.', 16, 1)
			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'' FotoProducto01,
				'' FotoProducto02,
				'' FotoProducto03,
				'' FotoProducto04,
				'' FotoProducto05,
				'' FotoProducto06,
				'' FotoProducto07,
				'' FotoProducto08,
				'' FotoProducto09,
				'' FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.CODIGO = @CampaniaID AND PC.CodigoProducto = @codigoSAP AND PC.CUV = @CUV1;
		END
		ELSE IF @flag = 3
		BEGIN
			DECLARE @numeroTallas INT = (SELECT COUNT(1) FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2);
			IF @numeroTallas = 1
			BEGIN
				DELETE FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END
			ELSE IF @numeroTallas > 1
			BEGIN
				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10
				FROM TallaColorCUV
				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';
			END
			ELSE
			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' FotoProducto01,
					'' FotoProducto02,
					'' FotoProducto03,
					'' FotoProducto04,
					'' FotoProducto05,
					'' FotoProducto06,
					'' FotoProducto07,
					'' FotoProducto08,
					'' FotoProducto09,
					'' FotoProducto10;
			END
		END
		
		ELSE IF @flag = 4
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPA�A ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campa�a actual.', 16, 1)
			END

			-- VALIDAR LA QUE EL CUV EST� CONFIGURADO EN LA MATRIZ COMERCIAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no est� configurado en la matriz comercial.', 16, 1)
			END

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				ISNULL(mc.FotoProducto01, '') FotoProducto01,
				ISNULL(mc.FotoProducto02, '') FotoProducto02,
				ISNULL(mc.FotoProducto03, '') FotoProducto03,
				ISNULL(mc.FotoProducto04, '') FotoProducto04,
				ISNULL(mc.FotoProducto05, '') FotoProducto05,
				ISNULL(mc.FotoProducto06, '') FotoProducto06,
				ISNULL(mc.FotoProducto07, '') FotoProducto07,
				ISNULL(mc.FotoProducto08, '') FotoProducto08,
				ISNULL(mc.FotoProducto09, '') FotoProducto09,
				ISNULL(mc.FotoProducto10, '') FotoProducto10
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				--CODIGOTIPOOFERTA IN (
				--	SELECT CODIGOOFERTA
				--	FROM TIPOESTRATEGIAOFERTA TE
				--	INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
				--	WHERE TIPOESTRATEGIAID = @TipoEstrategiaID ---OR 0 = @FlagOferta
				--)
				--AND 
				
				C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END

GO
