Use BelcorpChile
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
	select @EsquemaDAConsultora = EsquemaDAConsultora
	from pais with(nolock)
	where EstadoActivo = 1

	declare @ConfValZonaTemp table
	(
	 Campaniaid int,
	 Regionid int,
	 Zonaid int,
	 FechaInicioFacturacion smalldatetime,
	 FechaFinFacturacion smalldatetime,
	 CodigoRegion varchar(8),
	 CodigoZona varchar(8),
	 CodigoCampania int
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
	 PedidoDetalleIDPadre bit
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
	 ZonaId int
	)

	if @TipoCronograma = 1
	begin
	 insert into @ConfValZonaTemp
	 select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
	   cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
	   ,r.Codigo, z.Codigo, cast(ca.Codigo as int)
	 from ods.Cronograma cr with(nolock)
	 left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
	 inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId
	 inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId
	 inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId
	 left join cronograma co with(nolock) on cr.CampaniaId = co.CampaniaId and cr.ZonaId = co.ZonaId
	 where cr.FechaInicioFacturacion <= @FechaFacturacion and
	   cr.FechaInicioFacturacion + 10 >= @FechaFacturacion and
	   IIF(ISNULL(co.ZonaId,0) = 0,1,IIF(@EsquemaDAConsultora = 0,0,1)) = 1

	 IF @EsquemaDAConsultora = 0
	 BEGIN
	  insert into @tabla_pedido_detalle
	  select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
		c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)
	  from dbo.PedidoWeb p with(nolock)
	  join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	  and isnull(pd.EsKitNueva, '0') != 1
	  join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	  join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
		and c.RegionID = cr.RegionID
		and c.ZonaID = cr.ZonaID
	  left join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
	  where cr.FechaInicioFacturacion <= @FechaFacturacion
	   and cr.FechaFinFacturacion >= @FechaFacturacion
	   and isnull(da.TipoConfiguracion,0) = 0
	   --and p.ConsultoraId not in (
	   -- select ConsultoraId
	   -- from ConfiguracionConsultoraDA with(nolock)
	   -- where CampaniaId = p.CampaniaId and TipoConfiguracion = 1)
	 END
	end
	else
	begin
	 insert into @ConfValZonaTemp
	 select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioWeb,
	   cr.FechaFinWeb,r.Codigo, z.Codigo, cast(ca.Codigo as int)
	 from Cronograma cr with(nolock)
	 inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId
	 inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId
	 inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId
	 where cr.FechaInicioWeb = @FechaFacturacion

	 IF @EsquemaDAConsultora = 0
	 BEGIN
	  insert into @tabla_pedido_detalle
	  select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
		c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)
	  from dbo.PedidoWeb p with(nolock)
	  join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	  and isnull(pd.EsKitNueva, '0') != 1
	  join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	  join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
		and c.RegionID = cr.RegionID
		and c.ZonaID = cr.ZonaID
	  join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
	  where cr.FechaInicioFacturacion <= @FechaFacturacion
	   and cr.FechaFinFacturacion >= @FechaFacturacion
	   and da.TipoConfiguracion = 1
	   --and p.ConsultoraId in (
	   -- select ConsultoraId
	   -- from ConfiguracionConsultoraDA with(nolock)
	   -- where CampaniaId = p.CampaniaId and TipoConfiguracion = 1)
	 END
	end

	insert into @tabla_pedido
	select CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId
	from @tabla_pedido_detalle
	group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from @tabla_pedido p
	where 
		p.IndicadorEnviado = 0 and p.Bloqueado = 0
		and
		(@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,202,201))

	select 
		p.PedidoID, p.CampaniaID, p.CodigoConsultora,
		p.Clientes, p.CodigoRegion,
		p.CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,1,0) as Validado
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
