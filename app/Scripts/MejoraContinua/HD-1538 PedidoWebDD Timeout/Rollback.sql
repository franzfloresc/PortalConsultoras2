USE BelcorpBolivia
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpChile
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpColombia
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpCostaRica
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpDominicana
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpEcuador
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpGuatemala
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpMexico
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpPanama
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpPeru
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpPuertoRico
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpSalvador
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO
/*end*/

USE BelcorpVenezuela
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
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID				INT,
	@CampaniaID			INT,
	@RegionCodigo		VARCHAR(8) = NULL,
	@ZonaCodigo			VARCHAR(8),
	@CodigoConsultora	VARCHAR(25),
	@EstadoPedido		INT,
	@EsRechazado	INT = 0  
AS
BEGIN
SELECT  PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
	OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
FROM(
SELECT IDPROCESORECHAZO.IDPROCESO,pr.idprocesopedidorechazado,
p.PedidoID,
p.FechaRegistro FechaRegistro,
CASE WHEN p.EstadoPedido = 202
THEN p.FechaReserva
ELSE NULL
END FechaReserva,
p.CampaniaID CampaniaCodigo,
s.Codigo Seccion,
c.Codigo ConsultoraCodigo,
c.NombreCompleto ConsultoraNombre,
p.ImporteTotal,
p.DescuentoProl,
--'' UsuarioResponsable,
c.MontoSaldoActual ConsultoraSaldo,
'Web' OrigenNombre,
CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0
THEN 'SI'
ELSE 'NO'
END EstadoValidacionNombre,
z.Codigo AS Zona,
r.Codigo AS Region,
ide.Numero AS DocumentoIdentidad,
ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
c.MontoMinimoPedido,
0 AS ImporteTotalMM,
ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE
(STUFF((SELECT CAST(', ' +
CASE MR.Codigo
WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))
FROM GPR.PedidoRechazado P1
INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado AND p1.codigoconsultora=pr.codigoconsultora and p1.campania=pr.campania and p.GPRSB = 2  AND P1.Procesado = 1
and p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
FOR XML PATH ('')), 1, 1, '')) END
AS MotivoRechazo,
p.EstadoPedido,
p.GPRSB
--pr.IdPedidoRechazado
FROM dbo.PedidoWeb p (NOLOCK)
INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora AND CAST(pr.Campania AS INT) = @CampaniaID AND PR.PROCESADO=1
/* mostrar solo 1 registro por consultora.*/
LEFT JOIN (
SELECT PR1.CODIGOCONSULTORA,MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO FROM GPR.PROCESOPEDIDORECHAZADO _PR INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO

WHERE PR1.CAMPANIA=@CampaniaID GROUP BY PR1.CODIGOCONSULTORA
) IDPROCESORECHAZO
ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
AND PR.Campania=P.CAMPANIAID
INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
WHERE
(@CampaniaID is null or p.CampaniaID = @CampaniaID) and
p.ImporteTotal <> 0
AND(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 ))
AND (@EstadoPedido = 0 OR @EstadoPedido = (CASE WHEN p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0  THEN 202
ELSE
201
END ))
and (@RegionCodigo = '0' or @RegionCodigo is null or r.Codigo = @RegionCodigo)
AND (@ZonaCodigo = '0' or @ZonaCodigo is null or z.Codigo = @ZonaCodigo)
AND (@CodigoConsultora = '' or c.Codigo like '%' + @CodigoConsultora + '%')
--AND PR.PROCESADO=1
) T	WHERE MotivoRechazo  IS NOT NULL
GROUP BY PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
END
GO