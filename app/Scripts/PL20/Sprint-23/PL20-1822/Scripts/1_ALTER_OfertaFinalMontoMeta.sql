
USE BelcorpBolivia
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpChile
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpColombia
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpMexico
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpPanama
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpPeru
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS(
	SELECT 1 FROM sys.columns
	WHERE Name = N'TipoRango' AND OBJECT_ID = OBJECT_ID(N'OfertaFinalMontoMeta'))
BEGIN
	ALTER TABLE dbo.OfertaFinalMontoMeta
	ADD TipoRango VARCHAR(3) NULL, FechaRegistro DATETIME DEFAULT GETDATE();
END  
GO