
USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'IdMarca' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	DROP COLUMN IdMarca;
END  
GO
