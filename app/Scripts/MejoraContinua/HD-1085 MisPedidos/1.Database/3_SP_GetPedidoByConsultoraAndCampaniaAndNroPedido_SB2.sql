GO
IF OBJECT_ID('dbo.GetPedidoByConsultoraAndCampaniaAndNroPedido_SB2') IS NOT NULL
	DROP PROCEDURE dbo.GetPedidoByConsultoraAndCampaniaAndNroPedido_SB2
GO
CREATE PROCEDURE dbo.GetPedidoByConsultoraAndCampaniaAndNroPedido_SB2
	@CodigoConsultora VARCHAR(20),
	@Campania INT,
	@NroPedido VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	select top 1
		VPT.Consultora,
		VPT.NroPedido AS NumeroPedido,
		VPT.Campana,
		case
			when pfr.Periodo is null then VPT.Estado
			else 'ANULADO' end
		AS Estado,
		VPT.Fecha
	FROM vwPedidosTracking VPT with(nolock)
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		VPT.Campana = pfr.Periodo and
		pfr.CodigoConsultora = VPT.Consultora and
		VPT.NroPedido = pfr.NumeroPedido
	WHERE
		VPT.Consultora = @CodigoConsultora AND
		VPT.Campana = @Campania AND
		ISNULL(VPT.NroPedido,'') = ISNULL(@NroPedido,'');
END
GO

