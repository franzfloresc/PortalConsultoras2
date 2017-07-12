GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TipoDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	add TipoDespacho bit null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'FleteDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	add FleteDespacho decimal(15,2) null;
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'MensajeDespacho' AND Object_ID = Object_ID(N'dbo.CDRWeb'))
BEGIN
	alter table CDRWeb
	add MensajeDespacho varchar(200) null;
END
GO