

USE BelcorpBolivia
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO

USE BelcorpChile
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)


GO

USE BelcorpCostaRica
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)

GO


USE BelcorpDominicana
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO


USE BelcorpEcuador
go


IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO


USE BelcorpGuatemala
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO

USE BelcorpPanama
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO


USE BelcorpPuertoRico
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO

USE BelcorpSalvador
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO


USE BelcorpVenezuela
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)

GO

-----------------------------------------------------------------------------------------
USE BelcorpColombia
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)
GO

USE BelcorpMexico
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)


GO

USE BelcorpPeru
go

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'GPRSB') = 0
	ALTER TABLE dbo.PedidoWeb ADD GPRSB tinyint not null CONSTRAINT DF_PedidoWeb_GPRSB DEFAULT (0)

GO

