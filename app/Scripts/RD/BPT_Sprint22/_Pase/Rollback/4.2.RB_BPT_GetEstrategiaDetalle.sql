GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[GetEstrategiaDetalle]
	@EstrategiaID int
AS
BEGIN
SET NOCOUNT ON
	CREATE TABLE #TEstrategiaDetalle
	(
		EstrategiaID INT NOT NULL,
		ImgFondoDesktop varchar(500) NULL,
		ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL
	)

	DECLARE @Para1 int
	DECLARE @Para2 varchar(500)
	DECLARE @Para3 varchar(500)
	DECLARE @Para4 varchar(500)
	DECLARE @Para5 varchar(500)
	DECLARE @Para6 varchar(500)
	DECLARE @Para7 varchar(500)
	DECLARE @Para8 varchar(500)
	DECLARE @Para9 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 varchar(500)
	SET @Para1 = @EstrategiaID;
	SELECT @Para2 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10201'
	SELECT @Para3 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10202'
	SELECT @Para4 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10203'
	SELECT @Para5 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10204'
	SELECT @Para6 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10205'
	SELECT @Para7 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10206'
	SELECT @Para8 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10207'
	SELECT @Para9 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10208'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10209'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10210'
	SELECT @Para12 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @Para1 AND TablaLogicaDatosID = '10211'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile
	)
	VALUES
	(
		@Para1,
		@Para2,
		@Para3,
		@Para4,
		@Para5,
		@Para6,
		@Para7,
		@Para8,
		@Para9,
		@Para10,
		@Para11,
		@Para12
	)
	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END

GO
