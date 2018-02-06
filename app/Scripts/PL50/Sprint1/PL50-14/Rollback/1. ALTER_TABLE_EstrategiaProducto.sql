
USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN UsuarioCreacion;
END  
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaCreacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN FechaCreacion;
END 
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'UsuarioModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN UsuarioModificacion;
END 
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'FechaModificacion' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN FechaModificacion;
END 
GO
