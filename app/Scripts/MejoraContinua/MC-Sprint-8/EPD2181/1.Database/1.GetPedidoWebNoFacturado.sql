USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebNoFacturado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoWebNoFacturado]
GO

CREATE PROCEDURE [dbo].[GetPedidoWebNoFacturado]
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
			OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB
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
		ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,
		c.MontoMinimoPedido,
		0 AS ImporteTotalMM,
		ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,

		CASE WHEN p.GPRSB IN(1,0) THEN '' ELSE 
		(STUFF((SELECT CAST(', ' + 
			CASE MR.Codigo 
				WHEN 'OCC-16' THEN 'M�NIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
				WHEN 'OCC-17' THEN 'M�XIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 
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
	DescuentoProl,ConsultoraSaldo,OrigenNombre,EstadoValidacionNombre,Zona,Region ,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido, GPRSB

END


GO

