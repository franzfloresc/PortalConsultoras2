
USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

--SET @CodCampania = 201616
--SET @FechaInicioFact = '2016-12-29'

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
declare @flag BIT

SET @flag = 0

IF (@diaInicio = 0)
BEGIN
	SET @ddia = DATEDIFF(dd,GETDATE(),CAST(@FechaInicioFact AS DATE))
	IF (@ddia = 0)
		SET @flag = 1
END
ELSE
BEGIN
	DECLARE @fecaux DATETIME
	SET @fecaux = DATEADD(dd,@diaInicio,CAST(@FechaInicioFact AS DATE))
	SET @ddia = DATEDIFF(dd,GETDATE(),@fecaux)
	IF (@ddia = 0)
		SET @flag = 2
END

SELECT @flag AS flag

GO