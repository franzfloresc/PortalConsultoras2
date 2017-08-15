USE BelcorpBolivia
go

ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;

	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)

			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
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
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpChile
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpColombia
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpCostaRica
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpDominicana
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpEcuador
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpGuatemala
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpMexico
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpPanama
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpPeru
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpPuertoRico
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpSalvador
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO


USE BelcorpVenezuela
go

ALTER PROCEDURE ConsultarOfertaByCUV

	@CampaniaID		  INT,

	@CUV2			  VARCHAR(20),

	@TipoEstrategiaID INT,

	@CUV1			  VARCHAR(20),

	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS

--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;



	BEGIN TRY

		IF @flag = 0 OR @flag = 2

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

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



			--IF @flag = 0

			--BEGIN

			--	-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--	IF NOT EXISTS(

			--		SELECT 1

			--		FROM ods.ProductoComercial PC

			--		INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--		INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--		WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--	)

			--	BEGIN

			--		RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--	END

			--END



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

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,

				PC.CODIGOPRODUCTO AS CodigoSAP

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

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV1

			)

			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)

			END



			DECLARE @codigoSAP VARCHAR(20) = NULL;

			SELECT TOP 1 @codigoSAP = CodigoProducto

			FROM ods.ProductoComercial pc

			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID

			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;



			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)

			BEGIN

				RAISERROR('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END



			SELECT 

				PC.CUV,

				PC.Descripcion DescripcionCUV2,

				PC.PrecioUnitario, 

				'' IdMatrizComercial,

				'' CodigoSAP,

				1 AS EnMatrizComercial

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

					'' IdMatrizComercial,

					'' CodigoSAP

				FROM TallaColorCUV

				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

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

		

		ELSE IF @flag = 4

		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL

			IF NOT EXISTS(

				SELECT 1 

				FROM ods.ProductoComercial PC

				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

				WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			)

			BEGIN

				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)

			END



			-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL

			--IF NOT EXISTS(

			--	SELECT 1

			--	FROM ods.ProductoComercial PC

			--	INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID

			--	INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

			--	WHERE C.codigo = @CampaniaID AND CUV = @CUV2

			--)

			--BEGIN

			--	RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)

			--END



			SELECT

				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,

				PC.PrecioUnitario,

				mc.IdMatrizComercial,

				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,

				PC.CODIGOPRODUCTO AS CodigoSAP

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
GO




