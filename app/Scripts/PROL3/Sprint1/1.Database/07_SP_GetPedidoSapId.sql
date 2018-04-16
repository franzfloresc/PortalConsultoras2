GO
IF OBJECT_ID('dbo.GetPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.GetPedidoSapId
END
GO
create proc dbo.GetPedidoSapId
	@CampaniaID int,
	@PedidoID int
as
begin
	SELECT PedidoSapId
	FROM PedidoWeb (nolock)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO