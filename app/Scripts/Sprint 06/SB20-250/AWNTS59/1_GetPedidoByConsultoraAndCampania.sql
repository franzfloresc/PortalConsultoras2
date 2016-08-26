USE BelcorpColombia_SB2
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoByConsultoraAndCampania' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoByConsultoraAndCampania
END
GO
CREATE PROCEDURE dbo.GetPedidoByConsultoraAndCampania
	@CodigoConsultora VARCHAR(20),
	@Campania INT
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
	FROM vwPedidosTracking VPT
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		VPT.Campana = pfr.Periodo and
		pfr.CodigoConsultora = @CodigoConsultora and
		VPT.NroPedido = pfr.NumeroPedido
	WHERE
		VPT.Consultora = @CodigoConsultora
		AND
		VPT.Campana = @Campania;
END
GO
/*end*/

USE BelcorpMexico_SB2
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoByConsultoraAndCampania' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoByConsultoraAndCampania
END
GO
CREATE PROCEDURE dbo.GetPedidoByConsultoraAndCampania
	@CodigoConsultora VARCHAR(20),
	@Campania INT
AS
BEGIN
	SET NOCOUNT ON;

	select top 1
		VPT.Consultora,
		VPT.NroPedido AS NumeroPedido,
		VPT.Campana,
		VPT.Estado AS Estado,
		VPT.Fecha
	FROM vwPedidosTracking VPT
	WHERE
		VPT.Consultora = @CodigoConsultora
		AND
		VPT.Campana = @Campania;
END
GO
/*end*/

USE BelcorpPeru_SB2
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoByConsultoraAndCampania' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoByConsultoraAndCampania
END
GO
CREATE PROCEDURE dbo.GetPedidoByConsultoraAndCampania
	@CodigoConsultora VARCHAR(20),
	@Campania INT
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
	FROM vwPedidosTracking VPT
	left join ods.PedidoFacturadoRechazado pfr with(nolock) on
		VPT.Campana = pfr.Periodo and
		pfr.CodigoConsultora = @CodigoConsultora and
		VPT.NroPedido = pfr.NumeroPedido
	WHERE
		VPT.Consultora = @CodigoConsultora
		AND
		VPT.Campana = @Campania;
END
GO