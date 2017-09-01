GO
IF OBJECT_ID('UpdPedidoFICDetalle') IS NULL
	exec sp_executesql N'CREATE PROCEDURE UpdPedidoFICDetalle AS';
GO
ALTER PROCEDURE UpdPedidoFICDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null
AS
BEGIN
	UPDATE dbo.PedidoFICDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais()
	WHERE
		CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID;
END
GO