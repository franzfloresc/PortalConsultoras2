IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaResultadoDetalle' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaResultadoDetalle;

END
GO