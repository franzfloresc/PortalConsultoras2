USE BelcorpBolivia
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE GetPedidoWebNoFacturado
	@PaisID	INT,
	@CampaniaID	INT,
	@RegionCodigo VARCHAR(8) = NULL,
	@ZonaCodigo	VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@EstadoPedido INT,
	@EsRechazado INT = 0,
	@FechaRegistroInicio DATE = NULL,
	@FechaRegistroFin DATE = NULL
AS
BEGIN
	SELECT 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
	FROM(
		SELECT
			IDPROCESORECHAZO.IDPROCESO,
			pr.idprocesopedidorechazado,
			p.PedidoID,
			p.FechaRegistro FechaRegistro,
			iif(p.EstadoPedido = 202, p.FechaReserva, NULL) as FechaReserva,
			p.CampaniaID CampaniaCodigo,
			s.Codigo Seccion,
			c.Codigo ConsultoraCodigo,
			c.NombreCompleto ConsultoraNombre,
			p.ImporteTotal,
			p.DescuentoProl,
			c.MontoSaldoActual ConsultoraSaldo,
			'Web' OrigenNombre,
			iif(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0 AND p.ModificaPedidoReservadoMovil = 0, 'SI', 'NO') as EstadoValidacionNombre,
			z.Codigo as Zona,
			r.Codigo as Region,
			ide.Numero as DocumentoIdentidad,
			ISNULL(p.IndicadorEnviado,0) as IndicadorEnviado,
			c.MontoMinimoPedido,
			0 AS ImporteTotalMM,
			ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
			CASE
				WHEN p.GPRSB IN(1,0) THEN ''
				ELSE (STUFF((
					SELECT
						CAST(
							', ' +
							CASE MR.Codigo
								WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15))
								WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15))
								WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15))
								WHEN 'OCC-51' THEN 'MINIMO STOCK'
							END AS VARCHAR(MAX)
						)
					FROM GPR.PedidoRechazado P1
					INNER JOIN GPR.MotivoRechazo MR ON P1.MotivoRechazo = MR.Codigo
					WHERE
						pr.idprocesopedidorechazado = p1.idprocesopedidorechazado and
						p1.codigoconsultora=pr.codigoconsultora and
						p1.campania=pr.campania and
						p.GPRSB = 2 and
						P1.Procesado = 1 and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM dbo.PedidoWeb p (NOLOCK)
		INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid and c.zonaid = z.zonaid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid and r.regionid = s.regionid and z.zonaid = s.zonaid
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and CAST(pr.Campania AS INT) = @CampaniaID and PR.PROCESADO=1
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
			WHERE PR1.CAMPANIA=@CampaniaID
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=P.CAMPANIAID
		INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE
			p.ImporteTotal <> 0 and (@CampaniaID is null or p.CampaniaID = @CampaniaID) and			
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(isnull(@ZonaCodigo,'0') = '0' or z.Codigo = @ZonaCodigo) and
			(isnull(@RegionCodigo,'0') = '0' or r.Codigo = @RegionCodigo) and
			(isnull(@CodigoConsultora,'') = '' or c.Codigo like '%' + @CodigoConsultora + '%') and
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
	WHERE MotivoRechazo IS NOT NULL
	GROUP BY
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region, DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB;
END
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