IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaMotivo' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaMotivo;

END
GO