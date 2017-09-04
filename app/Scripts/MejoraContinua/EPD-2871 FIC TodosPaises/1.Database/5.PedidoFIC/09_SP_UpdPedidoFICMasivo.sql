GO
IF OBJECT_ID('UpdPedidoFICMasivo') IS NULL
	exec sp_executesql N'CREATE PROCEDURE UpdPedidoFICMasivo AS';
GO
ALTER PROCEDURE UpdPedidoFICMasivo
	@CampaniaID INT,
	@PedidoID INT,
	@EstadoPedido SMALLINT,
	@ModificaPedidoReservado BIT,
	@Clientes SMALLINT,
	@TotalPedido money,
	@CodigoUsuarioModificacion varchar(25) = null
AS
BEGIN
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	UPDATE dbo.PedidoFIC
	SET
		FechaModificacion = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ModificaPedidoReservado = @ModificaPedidoReservado,
		Clientes = @Clientes,
		ImporteTotal = @TotalPedido,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion
	WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
END
GO