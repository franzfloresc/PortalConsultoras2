GO
IF OBJECT_ID('dbo.DeletePedidoWebDetalleExplotadoByPedidoID') IS NOT NULL
BEGIN
	drop procedure dbo.DeletePedidoWebDetalleExplotadoByPedidoID
END
GO
create proc dbo.DeletePedidoWebDetalleExplotadoByPedidoID
	@CampaniaID int,
	@PedidoID int
as
begin
	delete from PedidoWebDetalleExplotado
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
end
GO