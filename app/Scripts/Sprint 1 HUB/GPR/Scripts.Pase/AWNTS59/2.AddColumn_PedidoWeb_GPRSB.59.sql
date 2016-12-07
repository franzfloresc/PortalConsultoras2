

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

