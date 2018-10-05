
USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioCreacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaCreacion DATETIME;
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD UsuarioModificacion VARCHAR(30);
END 

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FechaModificacion DATETIME;
END 

GO




