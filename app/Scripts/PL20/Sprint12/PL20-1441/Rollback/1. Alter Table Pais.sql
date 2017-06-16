

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais DROP COLUMN TieneCupon
END
GO
