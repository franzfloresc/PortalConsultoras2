USE BelcorpPeru
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] DROP Estado	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(500)
END
GO

