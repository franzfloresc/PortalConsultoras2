USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.ValidacionStockPROLLog') IS NOT NULL
BEGIN
	IF NOT EXISTS(
		SELECT 1 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ValidacionStockPROLLog' AND COLUMN_NAME = 'StockDisponible'
	)
	BEGIN
		ALTER TABLE dbo.ValidacionStockPROLLog
		ADD StockDisponible INT NULL;
	END
END
GO