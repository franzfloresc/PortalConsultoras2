USE BelcorpPeru
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpMexico
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpSalvador
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpPuertoRico
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpPanama
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpGuatemala
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpEcuador
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpDominicana
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpCostaRica
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpChile
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

GO

USE BelcorpBolivia
GO

alter PROCEDURE GetPedidoWebNoFacturado 
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
/*
set statistics io on

GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo=NULL,@CodigoConsultora=null,@RegionCodigo='10' ,@EstadoPedido=0,@EsRechazado=2

  GetPedidoWebNoFacturado_ipn  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
  GetPedidoWebNoFacturado  @CampaniaID=201805,@PaisID=11,@ZonaCodigo='1083',@CodigoConsultora=null,@RegionCodigo=NULL ,@EstadoPedido=0,@EsRechazado=2
*/
BEGIN

   declare @campaniav VARCHAR(10)= CONVERT(VARCHAR(10) ,@CampaniaID );
   declare @GPRSB tinyint =2
   declare @Procesado bit =1;
   declare @TipoDocumento VARCHAR(30)='1'
   
        

   SELECT 
     --x.consultoraid,
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,Numero DocumentoIdentidad, IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		 FROM

	(SELECT 
	     
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB,consultoraid
	FROM(

	 
		SELECT 
		    c.consultoraid,
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
			--ide.Numero as DocumentoIdentidad,
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
						--p.GPRSB = @GPRSB and
						P1.Procesado = @Procesado and
						p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO
					FOR XML PATH ('')
				), 1, 1, ''))
			END AS MotivoRechazo,
			p.EstadoPedido,
			p.GPRSB
			--pr.IdPedidoRechazado
		FROM   dbo.PedidoWeb p (NOLOCK)
		INNER JOIN  ods.Consultora c  (NOLOCK)   on     (p.consultoraid = c.consultoraid) and (p.CampaniaID =@CampaniaID)
		INNER JOIN ods.Zona z (NOLOCK) on  c.zonaid = z.zonaid
		INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
		INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
		LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora and pr.Campania = @campaniav and PR.PROCESADO=@Procesado
		/* mostrar solo 1 registro por consultora.*/
		LEFT JOIN (
			SELECT
				PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO
			FROM GPR.PROCESOPEDIDORECHAZADO _PR
			INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO   and PR1.CAMPANIA=@campaniav
			--WHERE PR1.CAMPANIA=@campaniav
			GROUP BY PR1.CODIGOCONSULTORA
		) IDPROCESORECHAZO ON
			PR.IDPROCESOPEDIDORECHAZADO = IDPROCESORECHAZO.IDPROCESO and
			IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO and
			PR.Campania=@campaniav
		--INNER JOIN ods.identificacion ide (NOLOCK) ON c.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = 1
		WHERE p.ImporteTotal <> 0 and
			(@EsRechazado = 2  OR (@EsRechazado = 1 AND p.GPRSB = 2) OR (@EsRechazado = 0 AND p.GPRSB <> 2 )) and
			(@EstadoPedido = 0 OR @EstadoPedido = iif(p.EstadoPedido = 202 and p.ValidacionAbierta = 0 and p.ModificaPedidoReservadoMovil = 0, 202, 201)) and
			(@ZonaCodigo IS NULL or (z.Codigo = @ZonaCodigo)) and 
			(@RegionCodigo is null or (r.Codigo = @RegionCodigo)) and
			((@CodigoConsultora is null)  or (c.Codigo =@CodigoConsultora)  ) and 
			(@FechaRegistroInicio is null or @FechaRegistroInicio <= CONVERT(date, p.FechaRegistro)) and
			(@FechaRegistroFin is null or @FechaRegistroFin >= CONVERT(date, p.FechaRegistro))
			--AND PR.PROCESADO=1
	) T
			WHERE MotivoRechazo IS NOT NULL

	) X
		  INNER JOIN ods.identificacion ide   ON  X.ConsultoraID = ide.ConsultoraID AND ide.DocumentoPrincipal = @TipoDocumento
		  
		GROUP BY 
		PedidoID,FechaRegistro,FechaReserva,CampaniaCodigo,Seccion ,ConsultoraCodigo,ConsultoraNombre,ImporteTotal,DescuentoProl,ConsultoraSaldo,
		OrigenNombre,EstadoValidacionNombre,Zona,Region,ide.Numero,IndicadorEnviado,MontoMinimoPedido,ImporteTotalMM,MotivoRechazo,EstadoPedido,GPRSB
		ORDER BY FechaRegistro
	--	OPTION	(OPTIMIZE FOR (@EsRechazado = 2,@EstadoPedido=0,@ZonaCodigo=null,@RegionCodigo=null,@CodigoConsultora=null,@FechaRegistroInicio=null,@FechaRegistroFin=null)) 
	--OPTION	(RECOMPILE)

END

