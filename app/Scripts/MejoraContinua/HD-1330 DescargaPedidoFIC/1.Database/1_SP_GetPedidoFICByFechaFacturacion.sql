GO
ALTER PROC GetPedidoFICByFechaFacturacion
	@FechaFacturacion date,
	@NroLote int
AS
BEGIN
	set nocount on;

	delete from TempPedidoFICID;
	insert into dbo.TempPedidoFICID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoFIC p
	join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca on p.CampaniaID = ca.Codigo
	join dbo.CronogramaFIC cr on ca.CampaniaID = cr.CampaniaID and c.ZonaID = cr.ZonaID
	where
		convert(date,cr.FechaFin) = @FechaFacturacion and
		exists(
			select 1
			from dbo.PedidoFICDetalle
			where CampaniaID = p.CampaniaID and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null
		);

	--**********************************INI: Cupon***********************************	   
    create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
    create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
    
	declare @tiene_cupon_pais bit = (select tieneCupon from Pais with(nolock) where EstadoActivo = 1);
    if @tiene_cupon_pais = 1 
    begin
        select
            p.PedidoID,
            p.CampaniaID,
            c.Codigo as CodigoConsultora
        into #temp
		from dbo.PedidoFIC p with(nolock)
		inner join dbo.TempPedidoFICID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
        inner join dbo.PedidoFICDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
        inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
        inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
        where pk.NroLote = @NroLote and pr.CodigoCatalago in (35,44,45,46) --35(Oferta Final), 44(Showroom), 45(Ofertas Para Ti) y 46(Oferta Del Día) 
        group by p.CampaniaID, p.PedidoID, c.Codigo
        having sum(pd.Cantidad) > 0;
 
        insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
        select distinct   
            pedido.CampaniaID,
            pedido.PedidoID,
            Cupon.CuponID,
            CodigoConsultora = CuponConsultora.CodigoConsultora,
			TipoCupon = right('00' + rtrim(ltrim(convert(varchar,Cupon.Tipo))),2),
			ValorCupon = right('000000000000' + replace(rtrim(ltrim(convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12)
        from #temp pedido
        inner join Cupon with (nolock) on pedido.CampaniaId = Cupon.CampaniaId and Cupon.Estado = 1
        inner join CuponConsultora with (nolock) On       
            Cupon.CuponID = CuponConsultora.CuponID and Cupon.CampaniaId = CuponConsultora.CampaniaId and  
            pedido.CodigoConsultora = CuponConsultora.CodigoConsultora and CuponConsultora.EstadoCupon = 2  
        inner Join Usuario with (nolock) on Usuario.CodigoConsultora = pedido.CodigoConsultora 
        where Usuario.EmailActivo = 1
            
        drop table #temp
    End  
    --**********************************FIN: Cupon ***********************************

	-- Cabecera de pedidos para descarga
	select 
		cast(p.PedidoID as varchar(6)) PedidoID, 
		cast(p.CampaniaID as varchar(6)) CampaniaID, 
		cast(c.Codigo as varchar(15)) as CodigoConsultora,
		cast(p.Clientes as varchar(5)) Clientes,
		cast(r.Codigo as varchar(2)) as CodigoRegion,
		cast(z.Codigo as varchar(6)) as CodigoZona,
		case p.EstadoPedido when 202 then 1 else 0 end as Validado,
		p.IPUsuario,
		isnull(pc.TipoCupon,'00') as TipoCupon,
		isnull(pc.ValorCupon,'000000000000') as ValorCupon
	from dbo.PedidoFIC p
	inner join dbo.TempPedidoFICID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	inner join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
	inner join ods.Region r on c.RegionID = r.RegionID
	inner join ods.Zona z on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
	left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select
		p.PedidoID, 
		cast(p.CampaniaID as varchar(6)) CampaniaID, 
		cast(c.Codigo as varchar(15)) as CodigoConsultora,
		cast(pd.CUV as varchar(10)) as CodigoVenta,
		pr.CodigoProducto,
		cast(sum(pd.Cantidad) as varchar(4)) as Cantidad
	from dbo.PedidoFIC p
	join dbo.TempPedidoFICID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
	join dbo.PedidoFICDetalle pd on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
	join ods.Campania ca on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by
		p.CampaniaID,
		p.PedidoID,
		p.EstadoPedido,
		c.Codigo,
		pd.CUV,
		pr.CodigoProducto,
		pr.IndicadorDigitable,
		pr.FactorRepeticion
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
END
GO