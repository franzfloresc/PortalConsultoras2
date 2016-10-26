USE BelcorpBolivia
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpChile
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpDominicana
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpEcuador
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpPanama
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpSalvador
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO
/*end*/

USE BelcorpColombia
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto04 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto05 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto06 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto07 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto08 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto09 VARCHAR(150) NULL;
END
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	ADD FotoProducto10 VARCHAR(150) NULL;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		mc.FotoProducto01,
		mc.FotoProducto02,
		mc.FotoProducto03,
		mc.FotoProducto04,
		mc.FotoProducto05,
		mc.FotoProducto06,
		mc.FotoProducto07,
		mc.FotoProducto08,
		mc.FotoProducto09,
		mc.FotoProducto10,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE ConsultarOfertaByCUV
	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }
AS
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3
BEGIN
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

			IF @flag = 0
			BEGIN
				-- VALIDAR LA QUE EL CUV ESTÁ CONFIGURADO EN LA MATRIZ COMERCIAL
				IF NOT EXISTS(
					SELECT 1
					FROM ods.ProductoComercial PC
					INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
					INNER JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
					WHERE C.codigo = @CampaniaID AND CUV = @CUV2
				)
				BEGIN
					RAISERROR('El CUV2 ingresado no está configurado en la matriz comercial.', 16, 1)
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
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO