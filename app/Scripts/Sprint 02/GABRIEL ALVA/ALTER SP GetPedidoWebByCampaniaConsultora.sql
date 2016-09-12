ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora
(
	@CampaniaID int,
	@ConsultoraID int
)
AS
BEGIN

SET NOCOUNT ON;

SELECT 
CampaniaID,
PedidoID,
ConsultoraID,
FechaRegistro,
FechaModificacion,
FechaReserva,
Clientes,
ImporteTotal,
ImporteCredito,
EstadoPedido,
ModificaPedidoReservado,
ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,
PaisID,
Bloqueado,
DescripcionBloqueo,
CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,
FechaProceso,
IPUsuario,
EstimadoGanancia,
CodigoUsuarioCreacion,
CodigoUsuarioModificacion,
MontoAhorro,
MontoDescuento
FROM dbo.PedidoWeb
WHERE 
CampaniaID = @CampaniaID AND
ConsultoraID = @ConsultoraID

END

