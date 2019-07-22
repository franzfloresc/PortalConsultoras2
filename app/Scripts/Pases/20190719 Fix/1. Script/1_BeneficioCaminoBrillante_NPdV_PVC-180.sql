USE BelcorpPeru
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

USE BelcorpMexico
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

USE BelcorpColombia
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

USE BelcorpSalvador
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

USE BelcorpPuertoRico
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

USE BelcorpPanama
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

USE BelcorpGuatemala
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

USE BelcorpEcuador
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

USE BelcorpDominicana
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

USE BelcorpCostaRica
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

USE BelcorpChile
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

USE BelcorpBolivia
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

