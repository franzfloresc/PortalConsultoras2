GO
ALTER PROCEDURE dbo.GetConsultoraEstadoSAC(
	@paisID VARCHAR(3),
	@codigoConsultora VARCHAR(20) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;

	declare @consultoraID bigint
	declare @ZonaID int
	declare @RegionID int
	declare @PaisID2 int
	declare @CampaniaID int
	declare @FechaFacturacion VARCHAR(10)
	declare @campaniaIngreso INT
	declare @campaniaUltima INT
	declare @pedidoFacturado INT
	declare @numeroCampania INT

	/*cargar tabla campaña*/
	create table  #temporalCampana(orden int  identity , id int, codigo varchar(6),campaniaIDCN int)

	insert into #temporalCampana
	select CampaniaID id, codigo ,campaniaIDCN from ods.Campania
	order by codigo;
	/*fin*/

	/*datos de busqueda*/
	set @PaisID2 = convert(int,isnull(@paisID,'0'))
	select
		@ZonaID = IsNull(C.ZonaID,0),
		@RegionID = IsNull(C.RegionID,0),
		@ConsultoraID = IsNull(C.ConsultoraID,0),
		@campaniaIngreso = AnoCampanaIngreso,
		@campaniaUltima = UltimaCampanaFacturada
	from ods.consultora C with(nolock)
	where C.Codigo = @codigoConsultora;
	/*fin*/

	/*fecha facturacion*/
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID2,@ZonaID,@RegionID,@ConsultoraID)

	select @FechaFacturacion = CONVERT(VARCHAR(10), FechaFinFacturacion, 103)
	FROM dbo.fnGetConfiguracionCampania(@PaisID2,@ZonaID,@RegionID,@ConsultoraID);
	/*fin*/

	/*calcular numero de campañas*/
 	DECLARE @chrCampaniaIngreso VARCHAR(6)
	set @chrCampaniaIngreso = convert(VARCHAR(6),@campaniaIngreso)
	DECLARE @chrCampaniaUltima VARCHAR(6)
	set @chrCampaniaUltima = convert(VARCHAR(6),@campaniaUltima)
	declare @orden int

	select @orden = orden from #temporalCampana where codigo = @chrCampaniaIngreso;

	select
		@pedidoFacturado = (isnull(orden - @orden, -1) + 1),
		@numeroCampania =(isnull(orden - @orden, -1) + 2)
	from #temporalCampana
	where codigo = @chrCampaniaUltima;
	/*Fin*/

	SELECT top 1
		C.ConsultoraID as consultoraID,
		C.Codigo AS codigo,
		E.Descripcion AS estadoConsultora,
		convert(VARCHAR(6),@campaniaIngreso) AS campanaIngreso,
		C.MontoMinimoPedido AS montoMinimo,
		S.Descripcion AS segmento,
		C.UltimaCampanaFacturada AS ultimaCampanaFacturada,
		C.MontoMaximoPedido AS montoMaximoPedido,
		autorizaPasarPedido = case C.AutorizaPedido when '1' then 'SI' when 'S' then 'SI' else 'NO' end,
		C.MontoUltimoPedido AS montoUltimoPedido,
		C.MontoSaldoActual AS montoSaldoActual,
		@CampaniaID AS campanaVigente,
		@FechaFacturacion AS fechaFacturacion,
		@pedidoFacturado AS pedidoFacturado,
		@numeroCampania As numeroCampania
	FROM ods.consultora C
	inner join ods.segmento S on S.SegmentoID =  C.SegmentoID
	inner join ods.estadoactividad E on E.IdEstadoActividad =  C.IdEstadoActividad
	where C.Codigo = @codigoConsultora;

	drop table #temporalCampana
END
GO