GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ValidacionDatos' AND TABLE_SCHEMA = 'dbo')
BEGIN
    DROP TABLE dbo.ValidacionDatos;
END
GO