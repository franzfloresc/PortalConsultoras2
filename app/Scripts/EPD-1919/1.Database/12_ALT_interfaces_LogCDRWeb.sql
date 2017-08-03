GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	add TipoDespacho bit null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	add FleteDespacho decimal(15,2) null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb
	add MensajeDespacho varchar(500) null;
END
GO