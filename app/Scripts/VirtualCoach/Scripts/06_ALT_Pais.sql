GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TieneAsesoraOnline' AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	ADD TieneAsesoraOnline INT NULL;
END
GO