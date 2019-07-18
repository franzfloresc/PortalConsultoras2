USE BelcorpPeru_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpMexico_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpColombia_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpSalvador_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpPuertoRico_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpPanama_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpGuatemala_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpEcuador_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpDominicana_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpCostaRica_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpChile_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

USE BelcorpBolivia_APP
GO

IF NOT EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ADD Estado bit	
END
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'Estado')
	Update [dbo].[BeneficioCaminoBrillante] set Estado = 1 
GO
IF EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BeneficioCaminoBrillante' AND COLUMN_NAME = 'UrlIcono')
BEGIN
	ALTER TABLE [dbo].[BeneficioCaminoBrillante] ALTER COLUMN UrlIcono VARCHAR(5)
END
GO

