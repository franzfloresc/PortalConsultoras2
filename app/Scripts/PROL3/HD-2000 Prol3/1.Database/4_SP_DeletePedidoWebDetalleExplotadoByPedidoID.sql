GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where PedidoID = @PedidoID;
end
GO