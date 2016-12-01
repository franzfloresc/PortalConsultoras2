USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo.QuitarBackOrderPedidoWebDetalle]
END

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO