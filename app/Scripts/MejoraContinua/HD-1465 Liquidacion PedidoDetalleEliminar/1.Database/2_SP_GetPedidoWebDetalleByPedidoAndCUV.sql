GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
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
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO