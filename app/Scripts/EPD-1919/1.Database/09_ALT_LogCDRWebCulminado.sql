GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	add TipoDespacho bit null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	add FleteDespacho decimal(15,2) null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'dbo.LogCDRWebCulminado'))
BEGIN
	alter table LogCDRWebCulminado
	add MensajeDespacho varchar(500) null;
END
GO