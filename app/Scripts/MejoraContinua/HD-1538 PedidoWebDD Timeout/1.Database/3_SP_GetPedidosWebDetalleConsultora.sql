GO
ALTER PROCEDURE GetPedidosWebDetalleConsultora
	@CampaniaID int,
	@RegionCodigo varchar(8) = null,
	@ZonaCodigo varchar(8),
	@CodigoConsultora varchar(25),
	@EstadoPedido int,
	@FechaRegistroInicio date = null,
	@FechaRegistroFin date = null
AS
BEGIN
	select
		r.Codigo RegionCodigo,
		z.Codigo Zona,
		c.Codigo ConsultoraCodigo,
		pd.CUV,
		sum(pd.Cantidad) Cantidad
	from dbo.PedidoWeb (nolock) p
	join dbo.PedidoWebDetalle (nolock) pd on p.CampaniaID = pd.CampaniaID and p.pedidoid = pd.pedidoid
	join ods.Consultora (nolock) c on p.consultoraid = c.consultoraid
	join ods.Region r on c.regionid = r.regionid
	join ods.Zona z on r.regionid = z.regionid and c.zonaid = z.zonaid
	--join ods.Seccion s on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
	where 
		p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		(@EstadoPedido = 0 or p.EstadoPedido = @EstadoPedido) and
		(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
		(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
		(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
		(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
		(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
	group by r.Codigo, z.Codigo, c.Codigo, pd.CUV;
END
GO