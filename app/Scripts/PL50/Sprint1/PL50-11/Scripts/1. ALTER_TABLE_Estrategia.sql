

USE BelcorpPeru_PL50
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN

	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END
