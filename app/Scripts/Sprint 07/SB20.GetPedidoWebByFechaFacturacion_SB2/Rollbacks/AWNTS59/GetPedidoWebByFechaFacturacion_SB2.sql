USE BelcorpColombia
Go

ALTER PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2 --'2014-02-14',1,1
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
	--from	ods.Cronograma cr
	--left join ConfiguracionValidacionZona cz on cr.zonaid = cz.zonaid
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
		and c.zonaid not in (select Zonaid 
							 from cronograma with(nolock)
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
		WHERE isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioWeb <= @FechaFacturacion
		and cr.FechaInicioDD >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle with(nolock) where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);

-- Cabecera de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	p.Clientes, r.Codigo as CodigoRegion,
	z.Codigo as CodigoZona,
	--(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado
	case p.EstadoPedido when 202 then 1 else 0 end as Validado
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Region r with(nolock) on c.RegionID = r.RegionID
	join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
where pk.NroLote = @NroLote
order by p.CampaniaID, p.PedidoID;

-- Detalle de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	pd.CUV as CodigoVenta, pr.CodigoProducto,
	/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
		then pr.FactorRepeticion * sum(pd.Cantidad)
		else sum(pd.Cantidad) end as Cantidad*/
		sum(pd.Cantidad) as Cantidad
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner hash join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
	join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo,
	pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
having sum(pd.Cantidad) > 0
order by CampaniaID, PedidoID, CodigoVenta

END


GO



USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2
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

-- Cabecera de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	p.Clientes, r.Codigo as CodigoRegion,
	z.Codigo as CodigoZona,
	--(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado
	case p.EstadoPedido when 202 then 1 else 0 end as Validado
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Region r with(nolock) on c.RegionID = r.RegionID
	join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
where pk.NroLote = @NroLote
order by p.CampaniaID, p.PedidoID;

-- Detalle de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	pd.CUV as CodigoVenta, pr.CodigoProducto,
	/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
		then pr.FactorRepeticion * sum(pd.Cantidad)
		else sum(pd.Cantidad) end as Cantidad*/
		sum(pd.Cantidad) as Cantidad
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
	join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo,
	pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
having sum(pd.Cantidad) > 0
order by CampaniaID, PedidoID, CodigoVenta

END


GO


Use belcorpPeru
GO


ALTER PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2 --'2015-10-19',1,1  
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
					select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
						c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
						IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)  
					from dbo.PedidoWeb p with(nolock)  
						join dbo.PedidoWebDetalle pd with(nolock) 
							on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
							AND isnull(PD.EsKitNueva, '0') != 1
						join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
						join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
							and c.RegionID = cr.RegionID  
							and c.ZonaID = cr.ZonaID  
					where cr.FechaInicioFacturacion <= @FechaFacturacion  
						and cr.FechaFinFacturacion >= @FechaFacturacion  
		END  
		ELSE  --  @EsquemaDAConsultora = 0  
		BEGIN  
					insert into @tabla_pedido_detalle  
					select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
						c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
						IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)  
					from dbo.PedidoWeb p with(nolock)  
						join dbo.PedidoWebDetalle pd with(nolock) 
							on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID  
							AND isnull(PD.EsKitNueva, '0') != 1
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
else -- @TipoCronograma = 1  
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
				select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
					c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
					IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)  
				from dbo.PedidoWeb p with(nolock)  
					join dbo.PedidoWebDetalle pd with(nolock) 
						on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID  
						AND isnull(PD.EsKitNueva, '0') != 1
					join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
					join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
						and c.RegionID = cr.RegionID  
						and c.ZonaID = cr.ZonaID  
				where cr.FechaInicioFacturacion <= @FechaFacturacion  
					and cr.FechaFinFacturacion >= @FechaFacturacion  
		END  
		ELSE  -- @EsquemaDAConsultora = 0 
		BEGIN  
				insert into @tabla_pedido_detalle  
				select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
					c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
					IIF(pd.PedidoDetalleIDPadre IS NULL,0,1)  
				from dbo.PedidoWeb p with(nolock)  
					join dbo.PedidoWebDetalle pd with(nolock) 
						on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID  
						AND isnull(PD.EsKitNueva, '0') != 1
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
select CampaniaId,PedidoId,Clientes,EstadoPedido,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,  
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId  
from @tabla_pedido_detalle  
group by CampaniaId,PedidoId,Clientes,EstadoPedido,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,  
	CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId  
  
insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)  
select @NroLote, p.CampaniaID, p.PedidoID  
from @tabla_pedido p  
where p.IndicadorEnviado = 0 and p.Bloqueado = 0  
  and (p.EstadoPedido = @Tipo OR @Tipo = 0)  
  
select p.PedidoID, p.CampaniaID, p.CodigoConsultora,  
 p.Clientes, p.CodigoRegion,  
 p.CodigoZona,  
 --(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado  
 case p.EstadoPedido when 202 then 1 else 0 end as Validado  
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
having sum(p.Cantidad) > 0  

END


GO
