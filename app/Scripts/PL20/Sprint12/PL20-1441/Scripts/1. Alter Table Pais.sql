

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO

/*end*/

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'TieneCupon' AND OBJECT_ID = OBJECT_ID(N'dbo.Pais'))
BEGIN
	ALTER TABLE dbo.Pais ADD TieneCupon int
END
GO
