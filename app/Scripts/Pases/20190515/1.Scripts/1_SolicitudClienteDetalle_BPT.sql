USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'Estado' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN Estado 
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
	WHERE Name = N'CantOriginal' AND OBJECT_ID = OBJECT_ID(N'SolicitudClienteDetalle'))
BEGIN
	ALTER TABLE dbo.SolicitudClienteDetalle
	DROP COLUMN CantOriginal 
END
GO

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD Estado BIT

ALTER TABLE dbo.SolicitudClienteDetalle 
ADD CantOriginal INT

