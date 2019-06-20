USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetEstrategiaDetalle', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetEstrategiaDetalle AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
@EstrategiaID int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImgFondoDesktop VARCHAR(500) = '',
		--@ImgPrevDesktop VARCHAR(500) = '',
		@ImgFichaDesktop VARCHAR(500) = '',
		@UrlVideoDesktop VARCHAR(500) = '',
		@ImgFondoMobile VARCHAR(500) = '',
		@ImgFichaMobile VARCHAR(500) = '',
		@UrlVideoMobile VARCHAR(500) = '',
		@ImgFichaFondoDesktop VARCHAR(500) = '',
		@ImgFichaFondoMobile VARCHAR(500) = '',
		@ImgHomeDesktop VARCHAR(500) = '',
		@ImgHomeMobile VARCHAR(500) = '',
		@FlagIndividual BIT = 0,
		@Slogan VARCHAR(500) = '',
		@ImgFondoApp VARCHAR(500) = '',
		@ColorTextoApp VARCHAR(500) = ''

	DECLARE @EstrategiaDetalle TABLE
	(
		TablaLogicaDatosID INT,
		Valor VARCHAR(500)

		PRIMARY KEY(TablaLogicaDatosID)
	)

	INSERT INTO @EstrategiaDetalle
	(
		Valor,
		TablaLogicaDatosID
	)
	SELECT
		Valor,
		TablaLogicaDatosID
	FROM dbo.EstrategiaDetalle (NOLOCK)
	WHERE EstrategiaID = @EstrategiaID

	SELECT @ImgFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10201'
	--SELECT @ImgPrevDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @ImgFichaDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10203'
	SELECT @UrlVideoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10204'
	SELECT @ImgFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10205'
	SELECT @ImgFichaMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10206'
	SELECT @UrlVideoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10207'
	SELECT @ImgFichaFondoDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10208'
	SELECT @ImgFichaFondoMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10209'
	SELECT @ImgHomeDesktop = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10210'
	SELECT @ImgHomeMobile = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10211'
	SELECT @FlagIndividual = CASE WHEN Valor = '1' THEN 1 ELSE 0 END FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10212'
	SELECT @Slogan = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10213'
	SELECT @ImgFondoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10214'
	SELECT @ColorTextoApp = ISNULL(Valor, '') FROM @EstrategiaDetalle WHERE TablaLogicaDatosID = '10215'

	SELECT
		@EstrategiaID AS EstrategiaID,
		@ImgFondoDesktop AS ImgFondoDesktop,
		--@ImgPrevDesktop AS ImgPrevDesktop,
		@ImgFichaDesktop AS ImgFichaDesktop,
		@UrlVideoDesktop AS UrlVideoDesktop,
		@ImgFondoMobile AS ImgFondoMobile,
		@ImgFichaMobile AS ImgFichaMobile,
		@UrlVideoMobile AS UrlVideoMobile,
		@ImgFichaFondoDesktop AS ImgFichaFondoDesktop,
		@ImgFichaFondoMobile AS ImgFichaFondoMobile,
		@ImgHomeDesktop AS ImgHomeDesktop,
		@ImgHomeMobile AS ImgHomeMobile,
		@FlagIndividual AS FlagIndividual,
		@Slogan AS Slogan,
		@ImgFondoApp AS ImgFondoApp,
		@ColorTextoApp AS ColorTextoApp

	SET NOCOUNT OFF
END
GO

