GO
ALTER PROCEDURE GetPedidosDDDetalleConsultora
	@chrPrefijoPais char(2),
	@CampaniaID char(6),
	@RegionCodigo char(2) = null,
	@ZonaCodigo char(6),
	@CodigoConsultora varchar(15)
AS
BEGIN

	select 
		r.Codigo AS RegionCodigo,
		z.Codigo AS Zona,
		c.Codigo AS ConsultoraCodigo,
		pd.CUV,
		SUM(pd.Cantidad) AS Cantidad
	from dbo.PedidoDD p 
		INNER JOIN dbo.PedidoDDDetalle pd ON p.CampaniaID = pd.CampaniaID AND p.PedidoID = pd.PedidoID
		INNER JOIN ods.Consultora c ON p.ConsultoraID = c.ConsultoraID
		INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
		INNER JOIN ods.Region r ON z.RegionID = r.RegionID
	where 
		pd.CampaniaID = @CampaniaID AND
		pd.IndicadorActivo = 1 AND 
		(@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo) AND
		(@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = RTRIM(@ZonaCodigo)) AND
		(@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
	group by r.Codigo, z.Codigo, c.Codigo, pd.CUV
END
GO