GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto04'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto04;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto05'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto05;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto06'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto06;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto07'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto07;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto08'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto08;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto09'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto09;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MatrizComercial' AND COLUMN_NAME = 'FotoProducto10'
))
BEGIN
	ALTER TABLE dbo.MatrizComercial
	DROP COLUMN FotoProducto10;
END
GO