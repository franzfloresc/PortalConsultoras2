

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'Activo' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProducto'))
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD Activo BIT DEFAULT 0;
END

