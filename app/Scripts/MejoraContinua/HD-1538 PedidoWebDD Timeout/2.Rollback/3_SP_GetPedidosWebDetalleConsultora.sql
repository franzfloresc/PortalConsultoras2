GO
ALTER PROCEDURE GetPedidosWebDetalleConsultora
	@CampaniaID int,
	@RegionCodigo varchar(8) = null,
	@ZonaCodigo varchar(8),
	@CodigoConsultora varchar(25),
	@EstadoPedido int
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
		(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
		p.ImporteTotal <> 0 and
		p.EstadoPedido = case when @EstadoPedido = 0 THEN p.EstadoPedido ELSE @EstadoPedido END
		and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
		and (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
		and (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
	group by r.Codigo, z.Codigo, c.Codigo, pd.CUV;
END
GO