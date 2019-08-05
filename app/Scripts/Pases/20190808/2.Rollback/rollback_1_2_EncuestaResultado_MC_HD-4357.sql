IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultado' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultado;

END
GO