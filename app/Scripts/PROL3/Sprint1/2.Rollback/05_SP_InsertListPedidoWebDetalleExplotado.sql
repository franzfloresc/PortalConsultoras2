GO
IF OBJECT_ID('dbo.InsertListPedidoWebDetalleExplotado') IS NOT NULL
BEGIN
	drop proc dbo.InsertListPedidoWebDetalleExplotado;
END
GO
IF TYPE_ID('dbo.PedidoWebDetalleExplotadoType') IS NOT NULL
	drop type dbo.PedidoWebDetalleExplotadoType;
GO