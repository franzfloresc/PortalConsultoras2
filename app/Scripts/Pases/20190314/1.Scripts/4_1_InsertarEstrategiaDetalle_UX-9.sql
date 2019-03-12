USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

IF (OBJECT_ID ( 'dbo.InsertarEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsertarEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[InsertarEstrategiaDetalle]
@EstrategiaID INT,
@FlagIndividual BIT = 0,
@Slogan VARCHAR(500) = '',
@ImgFondoDesktop VARCHAR(500) = '',
--@ImgPrevDesktop varchar(500) = '',
@ImgFichaDesktop VARCHAR(500) = '',
@UrlVideoDesktop VARCHAR(500) = '',
@ImgFondoMobile VARCHAR(500) = '',
@ImgFichaMobile VARCHAR(500) = '',
@UrlVideoMobile VARCHAR(500) = '',
@ImgFichaFondoMobile VARCHAR(500) = '',
@ImgFichaFondoDesktop VARCHAR(500) = '',
@ImgHomeDesktop VARCHAR(500) = '',
@ImgHomeMobile VARCHAR(500) = '',
@ImgFondoApp VARCHAR(500) = '',
@ColorTextoApp VARCHAR(7) = '',
@Retorno INT OUTPUT
AS
BEGIN
SET NOCOUNT ON
	BEGIN TRY
		IF(@EstrategiaID > 0)
		BEGIN

			DELETE FROM dbo.EstrategiaDetalle WHERE EstrategiaID = @EstrategiaID;
			-- Se ingresa los valores para la estrategia de lanzamineto.
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10201', @ImgFondoDesktop, '', 1);
			--INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			--VALUES (@EstrategiaID, '10202', @ImgPrevDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10203', @ImgFichaDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10204', @UrlVideoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10205', @ImgFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10206', @ImgFichaMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10207', @UrlVideoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10208', @ImgFichaFondoDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10209', @ImgFichaFondoMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10210', @ImgHomeDesktop, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10211', @ImgHomeMobile, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10212', case when @FlagIndividual = 1 then '1' else '0' end, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10213', @Slogan, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10214', @ImgFondoApp, '', 1);
			INSERT INTO dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosID, Valor, Descripcion, Estado)
			VALUES (@EstrategiaID, '10215', @ColorTextoApp, '', 1);

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

