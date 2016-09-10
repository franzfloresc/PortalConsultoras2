USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2015-10-19',1,1
 @FechaFacturacion date,
 @TipoCronograma int,
 @NroLote int
 with recompile
as
BEGIN
	set nocount on;

	declare @Tipo smallint
	if @TipoCronograma = 1
	 set @Tipo = (select isnull(ProcesoRegular,0) from [dbo].[ConfiguracionValidacion])
	else if @TipoCronograma = 2
	 set @Tipo = (select isnull(ProcesoDA,0) from [dbo].[ConfiguracionValidacion])
	else
	 set @Tipo = (select isnull(ProcesoDAPRD,0) from [dbo].[ConfiguracionValidacion])

	declare @EsquemaDAConsultora bit
	declare @TipoProcesoCarga bit
	select	@EsquemaDAConsultora = ISNULL(EsquemaDAConsultora,0),
			@TipoProcesoCarga = ISNULL(TipoProcesoCarga,0)
	from pais with(nolock)
	where EstadoActivo = 1

	declare @ConfValZonaTemp table
	(
		Campaniaid int,
		Regionid int,
		Zonaid int,
		FechaInicioFacturacion smalldatetime,
		FechaFinFacturacion smalldatetime,
		FechaFinNuevoProceso smalldatetime, --R20151221
		CodigoRegion varchar(8),
		CodigoZona varchar(8),
		CodigoCampania int,
		ZonaActivaTP bit,
		TipoProceso int
	)

	declare @tabla_pedido_detalle table
	(
		CampaniaId int null,
		PedidoId int null,
		Clientes int,
		EstadoPedido smallint null,
		ValidacionAbierta bit null,
		Bloqueado bit null,
		IndicadorEnviado bit null,
		ModificaPedidoReservadoMovil bit null,
		CodigoConsultora varchar(25) null,
		CodigoRegion varchar(8) null,
		CodigoZona varchar(8) null,
		CampaniaIdSicc int null,
		ZonaId int,
		CUV varchar(20) null,
		Cantidad int null,
		PedidoDetalleIDPadre bit,
		TipoProceso int
	)

	declare @tabla_pedido table
	(
		CampaniaId int null,
		PedidoId int null,
		Clientes int,
		EstadoPedido smallint null,
		ValidacionAbierta bit null,
		Bloqueado bit null,
		IndicadorEnviado bit null,
		ModificaPedidoReservadoMovil bit null,
		CodigoConsultora varchar(25) null,
		CodigoRegion varchar(8) null,
		CodigoZona varchar(8) null,
		CampaniaIdSicc int null,
		ZonaId int,
		TipoProceso int
	)

	IF @TipoCronograma = 1
	BEGIN
		insert into @ConfValZonaTemp
		select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
			cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0),
			cr.FechaInicioFacturacion + isnull(tp.DiasParametroCarga,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, tp.DiasParametroCarga, cr.FechaInicioFacturacion),0),  --R20151221
			r.Codigo, z.Codigo, cast(ca.Codigo as int),
			IIF(@TipoProcesoCarga=1,IIF(isnull(tp.ZonaId,0)=0,0,1),0),0
		from ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId
		inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId
		inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId
		left join cronograma co with(nolock) on cr.CampaniaId = co.CampaniaId and cr.ZonaId = co.ZonaId
		left join ConfiguracionTipoProceso tp with(nolock) on cr.ZonaId = tp.ZonaId
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
			cr.FechaInicioFacturacion + 10 >= @FechaFacturacion and
			IIF(ISNULL(co.ZonaId,0) = 0,1,IIF(@EsquemaDAConsultora = 0,0,1)) = 1

		update @ConfValZonaTemp
		--set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinFacturacion = @FechaFacturacion,3,2),1)
		set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinNuevoProceso <= @FechaFacturacion,3,2),1) --R20151221

		IF @EsquemaDAConsultora = 0
		BEGIN
			insert into @tabla_pedido_detalle
			select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
				c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso
			from dbo.PedidoWeb p with(nolock)
			join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
			and isnull(pd.EsKitNueva, '0') != 1  
			join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
			where cr.FechaInicioFacturacion <= @FechaFacturacion
				and cr.FechaFinFacturacion >= @FechaFacturacion
		END
		ELSE
		BEGIN
			insert into @tabla_pedido_detalle
			select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
				c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso
			from dbo.PedidoWeb p with(nolock)
			join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
			and isnull(pd.EsKitNueva, '0') != 1  
			join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
					left join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
			where	cr.FechaInicioFacturacion <= @FechaFacturacion
					and cr.FechaFinFacturacion >= @FechaFacturacion
					and isnull(da.TipoConfiguracion,0) = 0
	END
	END
	ELSE
	BEGIN
		insert into @ConfValZonaTemp
		select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioWeb,
			cr.FechaFinWeb,cr.FechaFinWeb,r.Codigo, z.Codigo, cast(ca.Codigo as int),
			IIF(@TipoProcesoCarga=1,IIF(isnull(tp.ZonaId,0)=0,0,1),0),0
		from Cronograma cr with(nolock)
		inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId
		inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId
		inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId
		left join ConfiguracionTipoProceso tp with(nolock) on cr.ZonaId = tp.ZonaId
		where cr.FechaInicioWeb = @FechaFacturacion

		update @ConfValZonaTemp
		--set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinFacturacion = @FechaFacturacion,3,2),1)
		set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinNuevoProceso <= @FechaFacturacion,3,2),1) --R20151221

		IF @EsquemaDAConsultora = 0
		BEGIN
			insert into @tabla_pedido_detalle
			select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
				c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso
			from dbo.PedidoWeb p with(nolock)
			join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
			and isnull(pd.EsKitNueva, '0') != 1  
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
			where cr.FechaInicioFacturacion <= @FechaFacturacion
				and cr.FechaFinFacturacion >= @FechaFacturacion
		END
		ELSE
		BEGIN
			insert into @tabla_pedido_detalle
			select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
				c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso
			from dbo.PedidoWeb p with(nolock)
			join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
			and isnull(pd.EsKitNueva, '0') != 1  
			join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
			join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
			where	cr.FechaInicioFacturacion <= @FechaFacturacion
					and cr.FechaFinFacturacion >= @FechaFacturacion
					and da.TipoConfiguracion = 1
		END
	END

	insert into @tabla_pedido
	select CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso
	from @tabla_pedido_detalle
	group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from @tabla_pedido p
	where
		p.IndicadorEnviado = 0 and p.Bloqueado = 0
		and
		(case p.TipoProceso
			when 1 then
				case @Tipo
					when 0 then 1
					when IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201) then 1
					else 0
				end
			when 2 then IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0)
			else 1
		end) = 1

	select
		p.PedidoID, p.CampaniaID, p.CodigoConsultora,
		p.Clientes, p.CodigoRegion,
		p.CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado
	from @tabla_pedido p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote


	select p.PedidoID, p.CampaniaID, p.CodigoConsultora,
	 p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad
	from @tabla_pedido_detalle p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
	where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0
	group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV
	having sum(p.Cantidad) > 0;
END

GO
