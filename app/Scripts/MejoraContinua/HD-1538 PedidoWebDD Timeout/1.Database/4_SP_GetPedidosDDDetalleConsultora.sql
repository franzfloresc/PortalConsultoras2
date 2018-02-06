GO
ALTER PROCEDURE GetPedidosDDDetalleConsultora
	@chrPrefijoPais char(2),
	@CampaniaID char(6),
	@RegionCodigo varchar(2) = null,
	@ZonaCodigo varchar(6),
	@CodigoConsultora varchar(15),
	@FechaRegistroInicio date = null,
	@FechaRegistroFin date = null
AS
BEGIN

	select 
		r.Codigo AS RegionCodigo,
		z.Codigo AS Zona,
		c.Codigo AS ConsultoraCodigo,
		pd.CUV,
		SUM(pd.Cantidad) AS Cantidad
	from dbo.PedidoDD p 
	inner join dbo.PedidoDDDetalle pd ON p.CampaniaID = pd.CampaniaID AND p.PedidoID = pd.PedidoID
	inner join ods.Consultora c ON p.ConsultoraID = c.ConsultoraID
	inner join ods.Zona z ON c.ZonaID = z.ZonaID
	inner join ods.Region r ON z.RegionID = r.RegionID
	where 
		pd.IndicadorActivo = 1 and pd.CampaniaID = @CampaniaID and		
		(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
		(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
		(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
		(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
		(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
	group by r.Codigo, z.Codigo, c.Codigo, pd.CUV
END
GO