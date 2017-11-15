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

	-- Cabecera de pedidos para descarga
	select 
		cast(p.PedidoID AS CHAR(6)) PedidoID, 
		cast(p.CampaniaID AS CHAR(6)) CampaniaID, 
		cast(c.Codigo AS CHAR(15)) as CodigoConsultora,
		cast(p.Clientes AS CHAR(5)) Clientes,
		cast(r.Codigo as char(2)) as CodigoRegion,
		cast(z.Codigo AS VARCHAR(6)) as CodigoZona,
		case p.EstadoPedido when 202 then 1 else 0 end as Validado
	from dbo.PedidoFIC p
	join dbo.TempPedidoFICID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c on p.ConsultoraID = c.ConsultoraID
	join ods.Region r on c.RegionID = r.RegionID
	join ods.Zona z on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select
		p.PedidoID, 
		cast(p.CampaniaID as char(6)) CampaniaID, 
		cast(c.Codigo as char(15)) as CodigoConsultora,
		cast(pd.CUV as char(10)) as CodigoVenta,
		pr.CodigoProducto,
		cast(sum(pd.Cantidad) as char(4)) as Cantidad
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