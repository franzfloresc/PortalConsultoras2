
USE BelcorpBolivia
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpChile
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpColombia
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpCostaRica
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpDominicana
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpEcuador
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpGuatemala
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpMexico
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpPanama
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpPeru
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpPuertoRico
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO

USE BelcorpSalvador
GO

DECLARE @TablaLogicaId INT = 181
DECLARE @Codigo VARCHAR(30) = '01'

IF EXISTS (SELECT 1 FROM dbo.TablaLogica WHERE TablaLogicaID = @TablaLogicaId)
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = @TablaLogicaId 
		AND Codigo = @Codigo)
	BEGIN
		PRINT 'delete TablaLogicaDatos : 181 - Codigo: 01'
		DELETE FROM dbo.TablaLogicaDatos where TablaLogicaID = @TablaLogicaId and Codigo = @Codigo 
    END
END
GO