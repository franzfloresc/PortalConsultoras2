GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
create proc dbo.ClearPedidoWebPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	update PedidoWeb
	set PedidoSapId = 0
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO