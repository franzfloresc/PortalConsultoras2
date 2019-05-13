

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP CantOriginal 
END
GO


