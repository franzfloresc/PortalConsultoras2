GO
ALTER PROCEDURE GetReportePedidoFIC --'201317', '90', 'x', ''
@CodigoCampania varchar(20),
@CodigoRegion varchar(20),
@CodigoZona varchar(20),
@CodigoConsultora varchar(20)
as
declare @CampaniaID int
declare @ZonaID int
declare @RegionID int
begin
	if	@CodigoRegion = 'x'
	begin
		select
			p.NombreCorto PAIS, @CodigoCampania PERIODO, z.Codigo ZONA, c.Codigo CUENTA, isnull(t.IdEstrategia, '') COD_ESTR, isnull(t.descripcion,'') VAL_I18N,
			isnull(NumeroOferta, '') NUM_OFER, pfd.CUV, pc.CodigoProducto PRODUCTO, pc.CodigoTipoOferta TIPO_OFETA, pfd.Cantidad UNIDADES, pfd.ImporteTotal VENTA_NETA,
			pf.FechaRegistro FechaRegistro,pf.FechaModificacion FechaModificacion
		from
			PedidoFICDetalle pfd 
			inner join ods.Campania ca on pfd.CampaniaID = ca.Codigo
			left join TempServiceProl t on pfd.CUV = t.CodVenta
			inner join ods.Consultora c on pfd.ConsultoraID = c.ConsultoraID
			inner join ods.Zona z on c.ZonaID = z.ZonaID
			left join ods.ProductoComercial pc on ltrim(rtrim(pfd.CUV)) = ltrim(rtrim(pc.CUV)) and pc.CampaniaID = ca.CampaniaID
			inner join Usuario u on c.Codigo = u.CodigoConsultora
			inner join Pais p on u.PaisID = p.PaisID
			left join pedidofic pf on pf.PedidoID=pfd.PedidoID
		where
			pfd.CampaniaID = @CodigoCampania and
			(C.Codigo = @CodigoConsultora OR @CodigoConsultora = '')
	end
	else
	begin
		select @RegionID = RegionID from ods.Region where Codigo = @CodigoRegion
		if	@CodigoZona = 'x'
		begin
			select
				p.NombreCorto PAIS, @CodigoCampania PERIODO, z.Codigo ZONA, c.Codigo CUENTA, isnull(t.IdEstrategia, '') COD_ESTR, isnull(t.descripcion,'') VAL_I18N,
			isnull(NumeroOferta, '') NUM_OFER, pfd.CUV, pc.CodigoProducto PRODUCTO, pc.CodigoTipoOferta TIPO_OFETA, pfd.Cantidad UNIDADES, pfd.ImporteTotal VENTA_NETA,
			pf.FechaRegistro FechaRegistro,pf.FechaModificacion FechaModificacion
			from
				PedidoFICDetalle pfd 
				inner join ods.Campania ca on pfd.CampaniaID = ca.Codigo
				left join TempServiceProl t on pfd.CUV = t.CodVenta
				inner join ods.Consultora c on pfd.ConsultoraID = c.ConsultoraID
				inner join ods.Zona z on c.ZonaID = z.ZonaID
				left join ods.ProductoComercial pc on ltrim(rtrim(pfd.CUV)) = ltrim(rtrim(pc.CUV)) and pc.CampaniaID = ca.CampaniaID
				inner join Usuario u on c.Codigo = u.CodigoConsultora
				inner join Pais p on u.PaisID = p.PaisID
				left join pedidofic pf on pf.PedidoID=pfd.PedidoID
			where
				pfd.CampaniaID = @CodigoCampania and
				z.ZonaID in (select ZonaID from ods.Zona where RegionID = @RegionID) and
				(C.Codigo = @CodigoConsultora OR @CodigoConsultora = '')
		end
		else
		begin
			select @ZonaID = ZonaID from ods.Zona where Codigo = @CodigoZona
			select
				p.NombreCorto PAIS, @CodigoCampania PERIODO, z.Codigo ZONA, c.Codigo CUENTA, isnull(t.IdEstrategia, '') COD_ESTR, isnull(t.descripcion,'') VAL_I18N,
				isnull(NumeroOferta, '') NUM_OFER, pfd.CUV, pc.CodigoProducto PRODUCTO, pc.CodigoTipoOferta TIPO_OFETA, pfd.Cantidad UNIDADES, pfd.ImporteTotal VENTA_NETA,
				pf.FechaRegistro FechaRegistro,pf.FechaModificacion FechaModificacion
			from
				PedidoFICDetalle pfd 
				inner join ods.Campania ca on pfd.CampaniaID = ca.Codigo
				left join TempServiceProl t on pfd.CUV = t.CodVenta
				inner join ods.Consultora c on pfd.ConsultoraID = c.ConsultoraID
				inner join ods.Zona z on c.ZonaID = z.ZonaID
				left join ods.ProductoComercial pc on ltrim(rtrim(pfd.CUV)) = ltrim(rtrim(pc.CUV)) and pc.CampaniaID = ca.CampaniaID
				inner join Usuario u on c.Codigo = u.CodigoConsultora
				inner join Pais p on u.PaisID = p.PaisID
				left join pedidofic pf on pf.PedidoID=pfd.PedidoID
			where
				pfd.CampaniaID = @CodigoCampania and
				z.ZonaID = @ZonaID and
				(C.Codigo = @CodigoConsultora OR @CodigoConsultora = '')
		end
	end
end
GO