USE BelcorpPeru
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpMexico
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpColombia
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpVenezuela
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpSalvador
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpPuertoRico
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpPanama
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpGuatemala
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpEcuador
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpDominicana
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpCostaRica
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpChile
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

USE BelcorpBolivia
GO

ALTER TABLE GPR.PedidoRechazado
ALTER COLUMN CodigoRechazoSomosBelcorp VARCHAR(50) 
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdPedidoRechazado') <> 0
	ALTER TABLE GPR.LogGPRValidacion DROP COLUMN IdPedidoRechazado
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'IdProcesoPedidoRechazado') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD IdProcesoPedidoRechazado BIGINT
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Campania') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Campania VARCHAR(6)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'Valor') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD Valor VARCHAR(10)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'CodigoConsultora') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD CodigoConsultora VARCHAR(15)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MotivoRechazo') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MotivoRechazo VARCHAR(200)
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMaximoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMaximoPedido [numeric](15, 2) NULL
GO

IF (SELECT COUNT(*) FROM dbo.sysobjects inner join dbo.syscolumns ON SYSOBJECTS.ID = SYSCOLUMNS.ID 
	WHERE sysobjects.id = object_id('GPR.LogGPRValidacion') and SYSCOLUMNS.NAME = N'MontoMinimoPedido') = 0
	ALTER TABLE GPR.LogGPRValidacion ADD MontoMinimoPedido [numeric](15, 2) NULL
GO

