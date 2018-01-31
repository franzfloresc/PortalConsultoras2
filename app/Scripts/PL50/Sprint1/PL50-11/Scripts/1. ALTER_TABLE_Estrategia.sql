

USE BelcorpColombia_PL50
GO
ALTER TABLE dbo.EstrategiaProducto ADD NombreProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD Descripcion1 VARCHAR (255)
ALTER TABLE dbo.EstrategiaProducto ADD ImagenProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD IdMarca TINYINT DEFAULT 0
ALTER TABLE dbo.EstrategiaProducto ADD Activo BIT DEFAULT 0

GO


USE BelcorpMexico_PL50
GO
ALTER TABLE dbo.EstrategiaProducto ADD NombreProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD Descripcion1 VARCHAR (255)
ALTER TABLE dbo.EstrategiaProducto ADD ImagenProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD IdMarca TINYINT DEFAULT 0
ALTER TABLE dbo.EstrategiaProducto ADD Activo BIT DEFAULT 0

GO


USE BelcorpPeru_PL50
GO
ALTER TABLE dbo.EstrategiaProducto ADD NombreProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD Descripcion1 VARCHAR (255)
ALTER TABLE dbo.EstrategiaProducto ADD ImagenProducto VARCHAR (150)
ALTER TABLE dbo.EstrategiaProducto ADD IdMarca TINYINT DEFAULT 0
ALTER TABLE dbo.EstrategiaProducto ADD Activo BIT DEFAULT 0

GO