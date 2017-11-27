USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilOrigen' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilOrigen]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'EsMovilFin' AND TABLE_NAME = 'CDRWeb')
BEGIN
	ALTER TABLE [dbo].[CDRWeb] DROP COLUMN [EsMovilFin]
END
GO