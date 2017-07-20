Use BelcorpCostaRica
go  
alter proc [dbo].[ESE_INT_OUT_DD_TRX_PEDIDO_SELECT] 
	@chrPrefijoPais char(2),
	@intSEQIDZonaGrupo int, -- 1 = Normal, 2 = DA
	@datFechaFacturacion date,
	@intNroLote int
as
set nocount on;


    IF (@intSEQIDZonaGrupo = 6) OR (@intSEQIDZonaGrupo = 1)
	BEGIN
	    insert into dbo.TempPedidoDDID (NroLote, CampaniaID, PedidoID)
			select distinct @intNroLote, p.CampaniaId, p.PedidoID
			from PedidoDD p with(nolock)
			join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
			join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
			join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
			where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
					p.IndicadorEnviado = 0 and pd.IndicadorActivo = 1 and --pd.IndicadorEnviado = 0 and
					cr.FechaInicioFacturacion <= @datFechaFacturacion and
					cr.FechaInicioReFacturacion >= @datFechaFacturacion and
					c.zonaid not in (select Zonaid 
									 from cronograma
									 where CampaniaID = ca.CampaniaID)
		
		 insert into dbo.TempPedidoDDDetID (NroLote, CampaniaID, PedidoID, PedidoDetalleID)
			select @intNroLote, p.CampaniaId, p.PedidoID, pd.PedidoDetalleId
			from PedidoDD p with(nolock)
			join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
			join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
			join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
			join ods.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
			where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
					p.IndicadorEnviado = 0 and pd.IndicadorActivo = 1 and pd.IndicadorEnviado = 0 and
					cr.FechaInicioFacturacion <= @datFechaFacturacion and
					cr.FechaInicioReFacturacion >= @datFechaFacturacion and
					c.zonaid not in (select Zonaid 
									 from cronograma
									 where CampaniaID = ca.CampaniaID)
									 
									 
	    
	END
	ELSE
	BEGIN
		insert into dbo.TempPedidoDDID (NroLote, CampaniaID, PedidoID)
		select distinct @intNroLote, p.CampaniaId, p.PedidoID
		from PedidoDD p with(nolock)
		inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
		inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
		where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
				p.IndicadorEnviado = 0 and pd.IndicadorActivo = 1 and --pd.IndicadorEnviado = 0 and
				cr.FechaInicioWeb <= @datFechaFacturacion and
				cr.FechaInicioDD >= @datFechaFacturacion
		
		
		insert into dbo.TempPedidoDDDetID (NroLote, CampaniaID, PedidoID, PedidoDetalleID)		
		select @intNroLote, p.CampaniaId, p.PedidoID, pd.PedidoDetalleId
		from PedidoDD p with(nolock)
		inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
		inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		inner join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		inner join dbo.Cronograma cr with(nolock) on ca.CampaniaId = cr.CampaniaId and c.ZonaId = cr.ZonaId
		where	p.IndicadorActivo = 1 and p.ImporteTotal <> 0 and 
				p.IndicadorEnviado = 0 and pd.IndicadorActivo = 1 and pd.IndicadorEnviado = 0 and
				cr.FechaInicioWeb <= @datFechaFacturacion and
				cr.FechaInicioDD >= @datFechaFacturacion
    END


select	p.PedidoID,
		p.CampaniaID,
		c.Codigo As CodigoConsultora,
		p.NumeroClientes As Clientes,
		r.Codigo As CodigoRegion,
		z.Codigo As CodigoZona,
		0 as Validado,
		'' AS IPUsuario,
		TipoCupon = '00',ValorCupon = '000000000000'  --Cupon
from TempPedidoDDID pk with(nolock)
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Region r with(nolock) on c.RegionId = r.RegionId
inner join ods.Zona z with(nolock) on c.RegionId = z.RegionId and c.ZonaId = z.ZonaId
where pk.NroLote = @intNroLote and p.PedidoID in (select distinct PedidoId from TempPedidoDDDetID where CampaniaId = p.CampaniaID and NroLote = @intNroLote)
order by p.PedidoId

select	p.PedidoId,
		p.CampaniaId,
		c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta,
		pr.CodigoProducto,
		sum(pd.Cantidad) as Cantidad,
		'' AS OrigenPedidoWeb
from TempPedidoDDID pk with(nolock)
inner join PedidoDD p with(nolock) on pk.CampaniaId = p.CampaniaId and pk.PedidoId = p.PedidoId
inner join PedidoDDDetalle pd with(nolock) on p.CampaniaId = pd.CampaniaId and p.PedidoId = pd.PedidoId
inner join TempPedidoDDDetID pdk with(nolock) on pd.CampaniaId = pdk.CampaniaId and pd.PedidoId = pdk.PedidoId and pd.PedidoDetalleID = pdk.PedidoDetalleID
inner join ods.Consultora c with(nolock) on p.ConsultoraId = c.ConsultoraId
inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @intNroLote and pdk.NroLote = @intNroLote
group by p.PedidoId, p.CampaniaId, c.Codigo, pd.CUV, pr.CodigoProducto
order by p.CampaniaId, p.PedidoId--, pd.CUV



GO