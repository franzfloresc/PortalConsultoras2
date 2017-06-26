USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneMasVendidos'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneMasVendidos;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneMasVendidos'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneMasVendidos;
END

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneOfertaLog'
          AND Object_ID = Object_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais
	DROP COLUMN TieneOfertaLog;
END

GO
