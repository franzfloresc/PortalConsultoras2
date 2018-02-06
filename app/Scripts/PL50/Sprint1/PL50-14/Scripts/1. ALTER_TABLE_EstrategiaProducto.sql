
USE BelcorpPeru_PL50
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
