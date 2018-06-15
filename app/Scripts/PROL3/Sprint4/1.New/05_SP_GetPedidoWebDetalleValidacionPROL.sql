GO
ALTER PROCEDURE GetPedidoWebDetalleValidacionPROL
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	SELECT
		PedidoDetalleID,
		CUV,
		Cantidad,
		PrecioUnidad,
		TipoOfertaSisID,
		ImporteTotal,
		FechaCreacion,
		AceptoBackOrder,
		EsKitNueva
	FROM PedidoWebDetalle WITH(NOLOCK)
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
END
GO