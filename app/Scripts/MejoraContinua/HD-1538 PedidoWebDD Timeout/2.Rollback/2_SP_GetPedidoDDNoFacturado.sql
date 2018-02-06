GO
ALTER PROCEDURE GetPedidoDDNoFacturado
	@chrPrefijoPais		CHAR(2),
	@CampaniaID			CHAR(6),
	@RegionCodigo		CHAR(2) = NULL,
	@ZonaCodigo			CHAR(6),
	@CodigoConsultora	VARCHAR(15)
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
		p.CampaniaID = @CampaniaID AND
		p.IndicadorActivo = 1 AND
		CASE
			WHEN @RegionCodigo = '0' THEN 1
			WHEN @RegionCodigo is null THEN 1
			WHEN r.Codigo = RTRIM(@RegionCodigo) THEN 1
			ELSE 0
		END = 1 AND
		CASE
			WHEN @ZonaCodigo = '0' THEN 1
			WHEN @ZonaCodigo is null THEN 1
			WHEN z.Codigo = RTRIM(@ZonaCodigo) THEN 1
			ELSE 0
		END = 1 AND
		CASE
			WHEN @CodigoConsultora = '' THEN 1
			WHEN c.Codigo like '%' + @CodigoConsultora + '%' THEN 1
			ELSE 0
		END = 1;
END
GO