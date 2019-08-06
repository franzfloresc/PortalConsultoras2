IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO
