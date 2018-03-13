
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO


