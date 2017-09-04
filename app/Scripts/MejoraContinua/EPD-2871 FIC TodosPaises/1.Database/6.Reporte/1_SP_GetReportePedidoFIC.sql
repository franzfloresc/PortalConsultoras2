GO
IF OBJECT_ID('GetReportePedidoFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetReportePedidoFIC AS';
GO
ALTER PROCEDURE GetReportePedidoFIC
	@CodigoCampania varchar(20),
	@CodigoRegion varchar(20),
	@CodigoZona varchar(20),
	@CodigoConsultora varchar(20)
as
begin
	declare @RegionID int = null;
	declare @ZonaID int = null;

	if @CodigoRegion <> 'x'
	begin
		select top 1 @RegionID = RegionID from ods.Region where Codigo = @CodigoRegion;	
		if @CodigoZona <> 'x'
			select @ZonaID = ZonaID from ods.Zona where Codigo = @CodigoZona;
	end

	select
		p.NombreCorto as PAIS,
		@CodigoCampania as PERIODO,
		z.Codigo as ZONA,
		c.Codigo as CUENTA,
		pfd.CUV,
		pc.CodigoProducto as PRODUCTO,
		pc.CodigoTipoOferta as TIPO_OFETA,
		pfd.Cantidad UNIDADES,
		pfd.ImporteTotal as VENTA_NETA,
		pf.FechaRegistro,
		pf.FechaModificacion
	from PedidoFICDetalle pfd 
	inner join ods.Campania ca on pfd.CampaniaID = ca.Codigo
	inner join ods.Consultora c on pfd.ConsultoraID = c.ConsultoraID
	inner join ods.Zona z on c.ZonaID = z.ZonaID
	left join ods.ProductoComercial pc on ltrim(rtrim(pfd.CUV)) = ltrim(rtrim(pc.CUV)) and pc.CampaniaID = ca.CampaniaID
	inner join Usuario u on c.Codigo = u.CodigoConsultora
	inner join Pais p on u.PaisID = p.PaisID
	left join pedidofic pf on pf.PedidoID=pfd.PedidoID
	where
		pfd.CampaniaID = @CodigoCampania and
		(@RegionID is null or z.RegionID = @RegionID) and
		(@ZonaID is null or z.ZonaID = @ZonaID) and
		(@CodigoConsultora = '' or c.Codigo = @CodigoConsultora);
end
GO