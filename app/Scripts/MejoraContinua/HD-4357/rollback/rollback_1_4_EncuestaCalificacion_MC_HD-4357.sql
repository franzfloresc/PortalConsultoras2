
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'EncuestaCalificacion' and schema_id = 1)
BEGIN

DROP TABLE dbo.EncuestaCalificacion;

END
GO
