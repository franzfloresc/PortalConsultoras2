GO
IF OBJECT_ID('DelPedidoFICDetalle') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelPedidoFICDetalle AS';
GO
ALTER PROCEDURE DelPedidoFICDetalle
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	DELETE FROM dbo.PedidoFICDetalle
	WHERE
		CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID;
END
GO