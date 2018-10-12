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
		--ImgPrevDesktop varchar(500) NULL,
		ImgFichaDesktop varchar(500) NULL,
		UrlVideoDesktop varchar(500) NULL,
		ImgFondoMobile varchar(500) NULL,
		ImgFichaMobile varchar(500) NULL,
		UrlVideoMobile varchar(500) NULL,
		ImgFichaFondoDesktop varchar(500) NULL,
		ImgFichaFondoMobile varchar(500) NULL,
		ImgHomeDesktop varchar(500) NULL,
		ImgHomeMobile varchar(500) NULL,
		FlagIndividual bit,
		Slogan varchar(500) NULL
	)

	DECLARE @ParaId int
	DECLARE @Para01 varchar(500)
	--DECLARE @Para02 varchar(500)
	DECLARE @Para03 varchar(500)
	DECLARE @Para04 varchar(500)
	DECLARE @Para05 varchar(500)
	DECLARE @Para06 varchar(500)
	DECLARE @Para07 varchar(500)
	DECLARE @Para08 varchar(500)
	DECLARE @Para09 varchar(500)
	DECLARE @Para10 varchar(500)
	DECLARE @Para11 varchar(500)
	DECLARE @Para12 bit
	DECLARE @Para13 varchar(500)

	SET @ParaId = @EstrategiaID;
	SELECT @Para01 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10201'
	--SELECT @Para02 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10202'
	SELECT @Para03 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10203'
	SELECT @Para04 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10204'
	SELECT @Para05 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10205'
	SELECT @Para06 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10206'
	SELECT @Para07 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10207'
	SELECT @Para08 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10208'
	SELECT @Para09 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10209'
	SELECT @Para10 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10210'
	SELECT @Para11 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10211'
	SELECT @Para12 = case when Valor = '1' then 1 else 0 end FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10212'
	SELECT @Para13 = ISNULL(Valor, '') FROM EstrategiaDetalle WHERE EstrategiaID = @ParaId AND TablaLogicaDatosID = '10213'

	INSERT INTO #TEstrategiaDetalle
	(
		EstrategiaID,
		ImgFondoDesktop,
		--ImgPrevDesktop,
		ImgFichaDesktop,
		UrlVideoDesktop,
		ImgFondoMobile,
		ImgFichaMobile,
		UrlVideoMobile,
		ImgFichaFondoDesktop,
		ImgFichaFondoMobile,
		ImgHomeDesktop,
		ImgHomeMobile,
		FlagIndividual,
		Slogan
	) 
	VALUES
	(
		@ParaId,
		@Para01,
		--@Para02,
		@Para03,
		@Para04,
		@Para05,
		@Para06,
		@Para07,
		@Para08,
		@Para09,
		@Para10,
		@Para11,
		@Para12,
		@Para13
	)

	SELECT * FROM #TEstrategiaDetalle

SET NOCOUNT OFF
END
GO