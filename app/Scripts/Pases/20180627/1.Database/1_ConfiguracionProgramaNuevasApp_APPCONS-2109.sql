USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CodigoNivel' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD CodigoNivel CHAR(2)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerCupon' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerCupon VARCHAR(100)
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ArchivoBannerPremio' AND TABLE_NAME = 'ConfiguracionProgramaNuevasApp')
	ALTER TABLE dbo.ConfiguracionProgramaNuevasApp ADD ArchivoBannerPremio VARCHAR(100)
GO

