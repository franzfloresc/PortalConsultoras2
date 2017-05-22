----------------------------------------------------
-- INSERTAR DETALLE DE ESTRATEGIA (TODOS LOS PAISES)
----------------------------------------------------

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategiaDetalle]
	@EstrategiaID int,
	@ImgFondoDesktop varchar(500),
	@ImgPrevDesktop varchar(500),
	@ImgFichaDesktop varchar(500),
	@UrlVideoDesktop varchar(500),
	@ImgFondoMobile varchar(500),
	@ImgFichaMobile varchar(500),
	@UrlVideoMobile varchar(500),
	@ImgFichaFondoMobile varchar(500),
	@ImgFichaFondoDesktop varchar(500),
	@Retorno int output
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoMobile, '', 1);
			INSERT INTO EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoDesktop, '', 1);
			SET @Retorno = 1;
		END
	END TRY
		
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH

SET NOCOUNT OFF
END
GO



