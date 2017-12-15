GO
ALTER PROCEDURE GetPedidoDDNoFacturado
	@chrPrefijoPais CHAR(2),
	@CampaniaID	CHAR(6),
	@RegionCodigo VARCHAR(2) = NULL,
	@ZonaCodigo	VARCHAR(6),
	@CodigoConsultora VARCHAR(15),
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT
		p.PedidoID,
		p.FechaRegistro,
		p.CampaniaID AS CampaniaCodigo,
		z.Codigo AS Zona,
		s.Codigo AS Seccion,
		c.Codigo AS ConsultoraCodigo,
		c.NombreCompleto AS ConsultoraNombre,
		i.Numero as DocumentoIdentidad,
		p.ImporteTotal,
		p.CodigoUsuarioCreacion AS UsuarioResponsable,
		c.MontoSaldoActual AS ConsultoraSaldo,
		'DD' AS OrigenNombre,
		'' AS EstadoValidacionNombre,
		p.IndicadorEnviado,
		c.MontoMinimoPedido,
		ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
		r.Codigo Region
	FROM dbo.PedidoDD (NOLOCK) p
	INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Identificacion (NOLOCK) i ON c.ConsultoraID = i.ConsultoraID AND i.DocumentoPrincipal = 1
	INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
	INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
	WHERE
		p.IndicadorActivo = 1 and
		p.CampaniaID = @CampaniaID and
		(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
		(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
		(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
		(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
		(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro));
END
GO