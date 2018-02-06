
USE BelcorpPeru_PL50
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	ADD NombreProducto VARCHAR(150);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	ADD Descripcion1 VARCHAR(255);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	ADD ImagenProducto VARCHAR(150);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	ADD IdMarca TINYINT;
END 

