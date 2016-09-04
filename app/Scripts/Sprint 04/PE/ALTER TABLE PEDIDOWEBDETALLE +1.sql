if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'OrdenPedidoWD') = 0
		ALTER TABLE dbo.PedidoWebDetalle 
		ADD OrdenPedidoWD int
go