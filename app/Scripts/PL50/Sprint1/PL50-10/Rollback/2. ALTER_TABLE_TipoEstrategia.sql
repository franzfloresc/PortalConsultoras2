
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 


USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'NombreProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN NombreProducto;
END  

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Descripcion1' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN Descripcion1;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenProducto' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN ImagenProducto;
END 

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END 

