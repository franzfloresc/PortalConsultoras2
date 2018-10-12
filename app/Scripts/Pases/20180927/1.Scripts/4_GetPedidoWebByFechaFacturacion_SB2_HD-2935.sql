USE [BelcorpPeru]
GO

ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2015-10-19',1,1
@FechaFacturacion date,
@TipoCronograma int,
@NroLote int
with recompile
as
/*
GetPedidoWebByFechaFacturacion_SB2 '2018-03-13',1,1598
*/
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
        IPUsuario varchar(25),
		TipoEstrategiaID int,
		EsKitNueva bit
       )

	   declare @tabla_pedido_detalle_temp table
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
        IPUsuario varchar(25),
		TipoEstrategiaID int,
		EsKitNueva bit
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
         insert into @tabla_pedido_detalle_temp
         select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
             c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario, pd.TipoEstrategiaID,isnull(PD.EsKitNueva, '0')
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID --AND isnull(PD.EsKitNueva, '0') != 1
         join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
         join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
             and c.RegionID = cr.RegionID
             and c.ZonaID = cr.ZonaID
         where cr.FechaInicioFacturacion <= @FechaFacturacion
          and cr.FechaFinFacturacion >= @FechaFacturacion
       END
       ELSE
       BEGIN
         insert into @tabla_pedido_detalle_temp
         select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
             c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario, pd.TipoEstrategiaID,isnull(PD.EsKitNueva, '0')
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID --AND isnull(PD.EsKitNueva, '0') != 1
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
         insert into @tabla_pedido_detalle_temp
         select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
             c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario, pd.TipoEstrategiaID,isnull(PD.EsKitNueva, '0')
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID --AND isnull(PD.EsKitNueva, '0') != 1
         join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
         join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania
             and c.RegionID = cr.RegionID
             and c.ZonaID = cr.ZonaID
         where cr.FechaInicioFacturacion <= @FechaFacturacion
          and cr.FechaFinFacturacion >= @FechaFacturacion
       END
       ELSE
       BEGIN
         insert into @tabla_pedido_detalle_temp
         select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.ValidacionAbierta,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,
             c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,
             IIF(pd.PedidoDetalleIDPadre IS NULL,0,1),
             pd.OrigenPedidoWeb,
             p.IPUsuario, pd.TipoEstrategiaID,isnull(PD.EsKitNueva, '0')
         from dbo.PedidoWeb p with(nolock)
         join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID --AND isnull(PD.EsKitNueva, '0') != 1
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

	   insert into @tabla_pedido_detalle
	   select *
	   from @tabla_pedido_detalle_temp
	   where EsKitNueva = 0

 
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
			 and CodigoConsultora not in (
				select CodigoConsultora from ConsultoraOficinaExonerada
			 )
 
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
             where pk.NroLote = @NroLote
             group by p.CampaniaID, p.PedidoID, p.CodigoConsultora
             having sum(p.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pwd.CampaniaID,   
              pwd.PedidoID,   
              c.CuponID,   
              CodigoConsultora = cc.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,c.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,cc.ValorAsociado))),'.',''),12) 
         From #temp pwd 
          Inner join Cupon c with (nolock) On  
                    pwd.CampaniaId = c.CampaniaId 
					And c.Estado = 1   
          Inner join CuponConsultora cc with (nolock) On       
                    c.CuponID = cc.CuponID 
					And c.CampaniaId = cc.CampaniaId 
					And pwd.CodigoConsultora = cc.CodigoConsultora 
					And cc.EstadoCupon = 2  

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
 
go