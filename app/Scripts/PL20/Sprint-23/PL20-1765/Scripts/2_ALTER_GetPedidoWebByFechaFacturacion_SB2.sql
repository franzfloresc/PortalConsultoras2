
USE BelcorpBolivia
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2]
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			


	-- Cabecera de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
        TipoCupon = isnull(pc.TipoCupon,'00') ,
        ValorCupon = isnull(pc.ValorCupon,'000000000000')			
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpChile
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
	declare @tiene_cupon_pais bit 
	select @EsquemaDAConsultora = EsquemaDAConsultora,@tiene_cupon_pais = tieneCupon
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
	 PedidoDetalleIDPadre bit,
	 OrigenPedidoWeb int,
	 IPUsuario varchar(25)
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
	 IPUsuario varchar(25)
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
		pd.OrigenPedidoWeb,
		p.IPUsuario
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
		pd.OrigenPedidoWeb,
		p.IPUsuario
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
		pd.OrigenPedidoWeb,
		p.IPUsuario
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
		IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
		pd.OrigenPedidoWeb,
		p.IPUsuario
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

	 END
	end

	insert into @tabla_pedido
	select CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,IPUsuario
	from @tabla_pedido_detalle
	group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,IPUsuario

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from @tabla_pedido p
	where 
		p.IndicadorEnviado = 0 and p.Bloqueado = 0
		and
		(@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,202,201))

       --**********************************Cupon***********************************
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    p.CodigoConsultora
             into #temp
             from @tabla_pedido_detalle p
             inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, p.CodigoConsultora
             having sum(p.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************

	select 
		p.PedidoID, p.CampaniaID, p.CodigoConsultora,
		p.Clientes, p.CodigoRegion,
		p.CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ModificaPedidoReservadoMovil = 0 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')		
	from @tabla_pedido p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote

	select p.PedidoID, p.CampaniaID, p.CodigoConsultora,
	 p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad, p.OrigenPedidoWeb
	from @tabla_pedido_detalle p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 --inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
	where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0
	group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV, p.OrigenPedidoWeb
	having sum(p.Cantidad) > 0;
END

GO


USE BelcorpColombia
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2]
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		--declare @ConfValZonaTemp table
		--(
		--	Campaniaid int,
		--	Regionid int,
		--	Zonaid int,
		--	FechaInicioFacturacion smalldatetime,

		--	FechaFinFacturacion smalldatetime
		--)

		--insert into @ConfValZonaTemp
		--select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
		--		cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		--from	ods.Cronograma cr with(nolock)
		--left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		--where	cr.FechaInicioFacturacion <= @FechaFacturacion and
		--		cr.FechaInicioFacturacion + 10 >= @FechaFacturacion


		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		--join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
		join ods.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			WHERE isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaInicioReFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle with(nolock) where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			WHERE isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaInicioDD >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle with(nolock) where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			
					
	-- Cabecera de pedidos para descarga
	select 
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')		
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		inner hash join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpCostaRica
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
	declare @tiene_cupon_pais bit 
	select	@EsquemaDAConsultora = ISNULL(EsquemaDAConsultora,0),
			@TipoProcesoCarga = ISNULL(TipoProcesoCarga,0),@tiene_cupon_pais = tieneCupon
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
		TipoProceso int,
		OrigenPedidoWeb int,
		IPUsuario VARCHAR(25)
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
		TipoProceso int ,
		IPUsuario varchar(25)
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario				
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario			
			from dbo.PedidoWeb p with(nolock)
			join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
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
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso,IPUsuario
	from @tabla_pedido_detalle
	group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso,IPUsuario

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

       --**********************************Cupon*********************************** 
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    p.CodigoConsultora
             into #temp
             from @tabla_pedido_detalle p
             inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, p.CodigoConsultora
             having sum(p.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************

	select
		p.PedidoID, p.CampaniaID, p.CodigoConsultora,
		p.Clientes, p.CodigoRegion,
		p.CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
        TipoCupon = isnull(pc.TipoCupon,'00') ,
        ValorCupon = isnull(pc.ValorCupon,'000000000000')		
	from @tabla_pedido p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote

	select p.PedidoID, p.CampaniaID, p.CodigoConsultora,
	 p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad, p.OrigenPedidoWeb
	from @tabla_pedido_detalle p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 --inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
	where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0
	group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV, p.OrigenPedidoWeb
	having sum(p.Cantidad) > 0;
END

GO


USE BelcorpDominicana
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-05-27',1,4
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr
		left join ConfiguracionValidacionZona cz on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p
		join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			and exists(
			select * from dbo.PedidoWebDetalle 
			where CampaniaID = p.CampaniaID
			and PedidoID = p.PedidoID 
			and Cantidad > 0 
			and PedidoDetalleIDPadre is null
			and isnull(EsKitNueva, '0') != 1
			)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p
		join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null 
			and isnull(EsKitNueva, '0') != 1)			
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			
       
	-- Cabecera de pedidos para descarga
	select 
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')						
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
		join ods.Region r on c.RegionID = r.RegionID
		join ods.Zona z on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
		inner hash join dbo.PedidoWebDetalle pd on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


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
	declare @tiene_cupon_pais bit 
	select	@EsquemaDAConsultora = ISNULL(EsquemaDAConsultora,0),
			@TipoProcesoCarga = ISNULL(TipoProcesoCarga,0),@tiene_cupon_pais = tieneCupon
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
		TipoProceso int,
		OrigenPedidoWeb int,
		IPUsuario varchar(25)
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
		TipoProceso int,
		IPUsuario varchar(25)
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
				IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso,
				pd.OrigenPedidoWeb,
				p.IPUsuario
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
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso,IPUsuario
	from @tabla_pedido_detalle
	group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso,IPUsuario

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

       --**********************************Cupon*********************************** 
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    p.CodigoConsultora
             into #temp
             from @tabla_pedido_detalle p
             inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, p.CodigoConsultora
             having sum(p.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************

	select
		p.PedidoID, p.CampaniaID, p.CodigoConsultora,
		p.Clientes, p.CodigoRegion,
		p.CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
        TipoCupon = isnull(pc.TipoCupon,'00') ,
        ValorCupon = isnull(pc.ValorCupon,'000000000000')			
	from @tabla_pedido p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote


	select p.PedidoID, p.CampaniaID, p.CodigoConsultora,
	 p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad, p.OrigenPedidoWeb
	from @tabla_pedido_detalle p
	 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	 --inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
	where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0
	group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV, p.OrigenPedidoWeb
	having sum(p.Cantidad) > 0;
END

GO


USE BelcorpGuatemala
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-06-05',1,1
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

	declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)

		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (select Zonaid
								 from cronograma
								 where CampaniaID = ca.CampaniaID)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			

	-- Cabecera de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		--(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')			
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpMexico
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2]
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			

	-- Cabecera de pedidos para descarga
	select 
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')					
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpPanama
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-06-05',1,1
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (select Zonaid
								 from cronograma
								 where CampaniaID = ca.CampaniaID)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)

			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			
			
	-- Cabecera de pedidos para descarga
	select
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')			
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
	
END

GO


USE BelcorpPeru
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
       declare @tiene_cupon_pais bit 
 
       select
             @EsquemaDAConsultora = EsquemaDAConsultora,
             @tiene_cupon_pais = tieneCupon
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
       PedidoDetalleIDPadre bit,
       OrigenPedidoWeb int,
        IPUsuario varchar(25)
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
       IPUsuario varchar(25)
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
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID AND isnull(PD.EsKitNueva, '0') != 1
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
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID AND isnull(PD.EsKitNueva, '0') != 1
         join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
         join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
             and c.RegionID = cr.RegionID
             and c.ZonaID = cr.ZonaID
         --left join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
         left join (
             select distinct CampaniaID, ConsultoraID, TipoConfiguracion
             from ConfiguracionConsultoraDA where isnull(TipoConfiguracion,0) = 0
         ) da on p.CampaniaId = da.CampaniaID and p.ConsultoraId = da.ConsultoraID
         where cr.FechaInicioFacturacion <= @FechaFacturacion
          and cr.FechaFinFacturacion >= @FechaFacturacion
          and isnull(da.TipoConfiguracion,0) = 0
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
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario  
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID AND isnull(PD.EsKitNueva, '0') != 1
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
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID AND isnull(PD.EsKitNueva, '0') != 1
         join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
         join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
             and c.RegionID = cr.RegionID
             and c.ZonaID = cr.ZonaID
         --join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
         left join (
             select distinct CampaniaID, ConsultoraID, TipoConfiguracion from
             dbo.ConfiguracionConsultoraDA where isnull(TipoConfiguracion,0) = 1
         ) da on p.CampaniaId = da.CampaniaID and p.ConsultoraId = da.ConsultoraID
         where cr.FechaInicioFacturacion <= @FechaFacturacion
          and cr.FechaFinFacturacion >= @FechaFacturacion
          and da.TipoConfiguracion = 1
       END
       end
 
       insert into @tabla_pedido
       select CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
       CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,IPUsuario
       from @tabla_pedido_detalle
       group by CampaniaId,PedidoId,Clientes,EstadoPedido,ValidacionAbierta,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,
       CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,IPUsuario
 
       insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
       select @NroLote, p.CampaniaID, p.PedidoID
       from @tabla_pedido p
       where
             p.IndicadorEnviado = 0 and p.Bloqueado = 0
             and
             (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201))
 
       --**********************************Cupon*********************************** 
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    p.CodigoConsultora
             into #temp
             from @tabla_pedido_detalle p
             inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, p.CodigoConsultora
             having sum(p.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************
      
       select
             p.PedidoID, p.CampaniaID, p.CodigoConsultora,
             p.Clientes, p.CodigoRegion,
             p.CodigoZona,
             IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
             p.IPUsuario,
             TipoCupon = isnull(pc.TipoCupon,'00') ,
             ValorCupon = isnull(pc.ValorCupon,'000000000000')
       from @tabla_pedido p
       inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
         left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
       where pk.NroLote = @NroLote;
 
       select p.PedidoID, p.CampaniaID, p.CodigoConsultora,
       p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad,p.OrigenPedidoWeb
       from @tabla_pedido_detalle p
       inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
       --inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV
       where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0
       group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV, p.OrigenPedidoWeb
       having sum(p.Cantidad) > 0;
END
 
GO


USE BelcorpPuertoRico
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2]
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin
		declare @ConfValZonaTemp table

		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo


		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130)
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			
       
	-- Cabecera de pedidos para descarga
	select
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')				
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo,pd.OrigenPedidoWeb,
		pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpSalvador
GO


ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-06-05',1,1
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
		cr.FechaInicioFacturacion + 10 >= @FechaFacturacion


		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (
				select Zonaid
				from cronograma
				where CampaniaID = ca.CampaniaID
			)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			

	-- Cabecera de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')		
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto,pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END

GO


USE BelcorpVenezuela
GO


ALTER proc [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-03-06',1,2
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
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

if @TipoCronograma = 1
begin

	declare @ConfValZonaTemp table
	(
		Campaniaid int,
		Regionid int,
		Zonaid int,
		FechaInicioFacturacion smalldatetime,
		FechaFinFacturacion smalldatetime
	)

	insert into @ConfValZonaTemp
	select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion, 
			cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
	from	ods.Cronograma cr with(nolock)
	left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
	where	cr.FechaInicioFacturacion <= @FechaFacturacion and 
			cr.FechaInicioFacturacion + 15 >= @FechaFacturacion

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		where isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioFacturacion <= @FechaFacturacion
		and cr.FechaFinFacturacion >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and c.zonaid not in (select Zonaid 
							 from cronograma
						     where CampaniaID = ca.CampaniaID)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);
end
else
	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		where isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioWeb <= @FechaFacturacion
		and cr.FechaFinWeb >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);

       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
 
             select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote and pr.CodigoCatalago in (SELECT Codigo FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 130) 
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2  
          Inner Join Usuario with (nolock) on  
                    Usuario.CodigoConsultora = pedido.CodigoConsultora 
         Where  
             Usuario.EmailActivo = 1
            
             drop table #temp
       End  
       --**********************************Cupon ***********************************			

-- Cabecera de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	p.Clientes, r.Codigo as CodigoRegion,
	z.Codigo as CodigoZona,
	--case p.EstadoPedido when 202 then 1 else 0 end as Validado
	(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado,
	p.IPUsuario,
	TipoCupon = isnull(pc.TipoCupon,'00') ,
	ValorCupon = isnull(pc.ValorCupon,'000000000000')		
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Region r with(nolock) on c.RegionID = r.RegionID
	join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
	left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
where pk.NroLote = @NroLote
order by p.CampaniaID, p.PedidoID;

-- Detalle de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	pd.CUV as CodigoVenta, pr.CodigoProducto,
	/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
		then pr.FactorRepeticion * sum(pd.Cantidad)
		else sum(pd.Cantidad) end as Cantidad*/
		sum(pd.Cantidad) as Cantidad,
		pd.OrigenPedidoWeb
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner hash join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
	join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo, pd.OrigenPedidoWeb,
	pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
having sum(pd.Cantidad) > 0
order by CampaniaID, PedidoID, CodigoVenta

END

GO
