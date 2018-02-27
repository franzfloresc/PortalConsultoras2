GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO
create type dbo.PedidoWebDetalleExplotadoType as table(
	PedidoID int not null,
	CUV varchar(6) not null
);
GO
create proc dbo.InsertListPedidoWebDetalleExplotado
	@ListPedidoWebDetalleExplotado dbo.PedidoWebDetalleExplotadoType readonly
as
begin
	insert into PedidoWebDetalleExplotado(
		PedidoID,
		CUV
	)
	select
		PedidoID,
		CUV
	from @ListPedidoWebDetalleExplotado;
end
GO