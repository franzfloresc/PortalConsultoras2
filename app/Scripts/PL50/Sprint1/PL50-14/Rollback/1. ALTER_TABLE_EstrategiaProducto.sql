

USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpColombia
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpMexico
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

USE BelcorpPanama
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

USE BelcorpPeru
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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



