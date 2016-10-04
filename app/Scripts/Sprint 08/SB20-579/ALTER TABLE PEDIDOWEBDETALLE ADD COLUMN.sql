if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'OrigenPedidoWeb') = 0
		ALTER TABLE dbo.PedidoWebDetalle 
		ADD OrigenPedidoWeb int
go