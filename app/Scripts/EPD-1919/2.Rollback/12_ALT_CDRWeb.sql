GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	drop column TipoDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	drop column FleteDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	drop column MensajeDespacho;
END
GO