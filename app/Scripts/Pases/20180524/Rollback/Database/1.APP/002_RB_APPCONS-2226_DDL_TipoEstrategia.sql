USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'MensajeValidacion' AND TABLE_NAME = 'TipoEstrategia')
	ALTER TABLE dbo.TipoEstrategia DROP COLUMN MensajeValidacion
GO

