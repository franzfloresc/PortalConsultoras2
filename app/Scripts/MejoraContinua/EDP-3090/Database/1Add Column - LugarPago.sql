IF Not EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'TextoPago'AND Object_ID = Object_ID(N'dbo.LugarPago'))
BEGIN
     Alter table LugarPago add TextoPago varchar(100) null 
END
go
IF Not EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'Posicion' AND Object_ID = Object_ID(N'dbo.LugarPago'))
BEGIN
    Alter table LugarPago add Posicion int null 
END
