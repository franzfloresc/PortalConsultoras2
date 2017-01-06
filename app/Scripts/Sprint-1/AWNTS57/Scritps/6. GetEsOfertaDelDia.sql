
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/


USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

CREATE PROCEDURE [dbo].[GetEsOfertaDelDia]
(
	@CodCampania INT,
	@CodConsultora VARCHAR(30),
	@FechaInicioFact DATETIME
)
AS

DECLARE @diaInicio INT

SELECT TOP 1 @diaInicio = DiaInicio 
FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CodCampania
AND TipoPersonalizacion = 'ODD'
AND CodConsultora = @CodConsultora

DECLARE @ddia INT
DECLARE @flag INT

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


