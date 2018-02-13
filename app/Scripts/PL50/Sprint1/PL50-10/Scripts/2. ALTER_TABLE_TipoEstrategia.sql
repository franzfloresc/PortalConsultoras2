
USE BelcorpBolivia
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


USE BelcorpChile
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

USE BelcorpColombia
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpMexico
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

USE BelcorpPanama
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

USE BelcorpPeru
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


USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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


USE BelcorpPeru_PL50
GO


