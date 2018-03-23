GO
IF OBJECT_ID('dbo.UpdListBackOrderPedidoWebDetalle') IS NOT NULL
BEGIN
	drop proc dbo.UpdListBackOrderPedidoWebDetalle;
END
GO
IF TYPE_ID('dbo.IdSmallintType') IS NOT NULL
	drop type dbo.IdSmallintType;
GO
create type dbo.IdSmallintType as table(Id smallint not null);
GO