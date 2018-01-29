USE BelcorpColombia_PL50
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Activo;
END  
GO

USE BelcorpMexico_PL50
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Activo;
END  
GO


USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN Activo;
END  
GO