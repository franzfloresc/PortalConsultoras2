GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO