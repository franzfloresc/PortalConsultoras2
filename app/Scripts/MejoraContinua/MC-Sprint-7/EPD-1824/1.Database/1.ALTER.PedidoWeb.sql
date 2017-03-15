USE BelcorpPeru
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpMexico
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpColombia
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpVenezuela
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpSalvador
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpPuertoRico
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpPanama
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpGuatemala
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpEcuador
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpDominicana
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpCostaRica
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpChile
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

USE BelcorpBolivia
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'Hostname') = 0
	ALTER TABLE dbo.PedidoWeb ADD Hostname VARCHAR(35)
GO

