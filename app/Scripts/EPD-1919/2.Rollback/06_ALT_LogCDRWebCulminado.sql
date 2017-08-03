GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	drop column TipoDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	drop column FleteDespacho;
END
GO
IF EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	drop column MensajeDespacho;
END
GO