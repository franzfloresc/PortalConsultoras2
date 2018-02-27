GO
IF OBJECT_ID('dbo.PedidoWebDetalleExplotado') IS NULL
BEGIN
	create table dbo.PedidoWebDetalleExplotado(
		PedidoWebDetalleExplotadoID bigint identity(1,1) primary key,
		PedidoID int not null,
		CUV varchar(6) not null
	)

	create nonclustered index IX_PedidoWebDetalleExplotado_PedidoID on dbo.PedidoWebDetalleExplotado(PedidoID)
END
GO