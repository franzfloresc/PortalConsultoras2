GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	drop column TipoDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	drop column FleteDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	drop column MensajeDespacho;
END
GO