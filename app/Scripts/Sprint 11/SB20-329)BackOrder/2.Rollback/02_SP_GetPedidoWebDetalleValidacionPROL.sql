-- Todos los paises excepto BO, CL, VE
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
		FechaCreacion
	FROM PedidoWebDetalle
	WHERE
		CampaniaID = @CampaniaID
		AND
		PedidoID = @PedidoID;
END
GO