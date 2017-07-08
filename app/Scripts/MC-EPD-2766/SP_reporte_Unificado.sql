Use BelcorpBolivia
go


/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO


Use BelcorpChile
go


/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO


Use BelcorpColombia
go


/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO


Use BelcorpCostaRica
go


/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpEcuador
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpSalvador
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpGuatemala
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpMexico
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpPanama
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpPeru
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpPuertoRico
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpDominicana
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO

Use BelcorpVenezuela
go

/****** Object:  StoredProcedure [dbo].[GetPedidoNoFacturado]    Script Date: 12/06/2017 10:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoNoFacturado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPedidoNoFacturado] AS' 
END
GO

--exec GetPedidoNoFacturado 2, 11, 201709,'0','0','',0,2,null,null,null,null,null
--go
--exec GetPedidoNoFacturado 1, null, null,null,null,null,null,null,'PE','201709', '0','0',''
--go
--exec GetPedidoNoFacturado 0, 11, 201709, '0', '0', '', 0, 2, 'PE', '201709', '0', '0', ''
--go

ALTER PROCEDURE [dbo].[GetPedidoNoFacturado]
(
	@TipoConsulta Char(1) = null,
	
	--Campos Web
	@WebPaisID Int = null,
	@WebCampaniaId Int = null,
	@WebRegionCodigo Varchar(8) = null,
	@WebZonaCodigo Varchar(8) = null,
	@WebCodigoConsultora Varchar(25) = null,
	@WebEstadoPedido Int = null,
	@WebEsRechazado Int = 0,
	
	--Campos DD	
	@DDPrefijoPais Char(2) = null,
	@DDCampaniaId Char(6) = null,
	@DDRegionCodigo Char(2) = null,
	@DDZonaCodigo Char(6) = null,
	@DDCodigoConsultora VarChar(15) = null	
 )
as
begin
	create table #TempTablePedidoNoFact
	(
		PedidoID int null, 
		FechaRegistro datetime null, 
		FechaReserva datetime null, --Web
		CampaniaCodigo int null, 
		Zona varchar(8) null, 
		Seccion varchar(8) null,
		ConsultoraCodigo varchar(25) null,
		ConsultoraNombre varchar(200) null,
		DescuentoProl money null, --Web
		ImporteTotal money null, --DD
		ConsultoraSaldo decimal(15,2) null,
		OrigenNombre varchar(10) null,
		EstadoValidacionNombre varchar(10) null,
		EstadoValidacion int null, 
		Region varchar(8) null, --Web
		IndicadorEnviado bit null,
		MontoMinimoPedido numeric(15,2) null,
		ImporteTotalMM decimal(12,2) null,		
		UsuarioResponsable varchar(25) null,
		MotivoRechazo varchar(max) null
	)
	
	if (@TipoConsulta = 1 or isnull(@TipoConsulta,0) = 0  )
	begin
		With TablePedidosDDNoFacturados
		as (
			SELECT	p.PedidoID,
					p.FechaRegistro,
					p.CampaniaID AS CampaniaCodigo,
					z.Codigo AS Zona,
					s.Codigo AS Seccion,
					c.Codigo AS ConsultoraCodigo,
					c.NombreCompleto AS ConsultoraNombre,
					p.ImporteTotal,
					--p.CodigoUsuarioCreacion AS UsuarioResponsable,
					c.MontoSaldoActual AS ConsultoraSaldo,
					'DD' AS OrigenNombre, 
					'NO' AS EstadoValidacionNombre, --DICC 07062017
					201 EstadoValidacion,--DICC 07062017
					p.IndicadorEnviado,
					c.MontoMinimoPedido,
					ISNULL(dbo.fnObtenerImporteMM(p.CampaniaID,p.PedidoID,'DD'), 0) AS ImporteTotalMM,
					ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
					r.Codigo Region
			FROM 
				dbo.PedidoDD (NOLOCK) p
				INNER JOIN ods.Consultora (NOLOCK) c ON p.ConsultoraID = c.ConsultoraID
				INNER JOIN ods.Region (NOLOCK) r on c.regionid = r.regionid
				INNER JOIN ods.Zona (NOLOCK) z ON c.ZonaID = z.ZonaID
				INNER JOIN ods.Seccion (NOLOCK) s ON c.SeccionID = s.SeccionID
			WHERE 
				p.CampaniaID = @DDCampaniaID AND
				p.IndicadorActivo = 1 AND
					CASE
						WHEN @DDRegionCodigo = '0' THEN 1
						WHEN @DDRegionCodigo is null THEN 1
						WHEN r.Codigo = RTRIM(@DDRegionCodigo) THEN 1
						ELSE 0
					END = 1 
					AND 
					CASE
						WHEN @DDZonaCodigo = '0' THEN 1
						WHEN @DDZonaCodigo is null THEN 1
						WHEN z.Codigo = RTRIM(@DDZonaCodigo) THEN 1
						ELSE 0
					END = 1 AND
					CASE
						WHEN @DDCodigoConsultora = '' THEN 1
						WHEN c.Codigo like '%' + @DDCodigoConsultora + '%' THEN 1
						ELSE 0
					END = 1
			)

	Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
		)
	select PedidoID,
	       FechaRegistro,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   EstadoValidacion, --DICC 07062017
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable
	From TablePedidosDDNoFacturados
	END -- First If	

	IF(@Tipoconsulta = 2  or isnull(@TipoConsulta,0) = 0  )
	begin
		 --EDP-2766
		 With TableIdProcesoRechazo as (
				SELECT PR1.CODIGOCONSULTORA,
				MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				WHERE PR1.CAMPANIA=@WebCampaniaID  
				GROUP BY PR1.CODIGOCONSULTORA
			)	
		
		,PreTablePedidosWebNoFacturados as (
				SELECT IDPROCESORECHAZO.IDPROCESO,
					   pr.idprocesopedidorechazado,			
					   p.PedidoID,		
					   p.FechaRegistro FechaRegistro,
					   CASE 
							WHEN p.EstadoPedido = 202 THEN p.FechaReserva		
							ELSE NULL		
					   END FechaReserva,		
					   p.CampaniaID CampaniaCodigo,		
					   s.Codigo Seccion,		
					   c.Codigo ConsultoraCodigo,		
					   c.NombreCompleto ConsultoraNombre,		
					   p.ImporteTotal,		
					   p.DescuentoProl,		
					   c.MontoSaldoActual ConsultoraSaldo,		
					   'Web' OrigenNombre,		
					   CASE 
							WHEN p.EstadoPedido = 202 
								AND p.ValidacionAbierta = 0 
								AND p.ModificaPedidoReservadoMovil = 0			
								THEN 'SI'			
							ELSE 'NO'									
						END EstadoValidacionNombre,		
						z.Codigo AS Zona,		
						r.Codigo AS Region,		
						ISNULL(p.IndicadorEnviado,0) AS IndicadorEnviado,		
						c.MontoMinimoPedido,		
						0 AS ImporteTotalMM,		
						ISNULL(p.CodigoUsuarioModificacion, p.CodigoUsuarioCreacion) AS UsuarioResponsable,
						CASE 
							WHEN p.GPRSB IN(1,0) THEN '' 
							ELSE (STUFF((SELECT CAST(', ' + CASE MR.Codigo 				
																WHEN 'OCC-16' THEN 'MÍNIMO: ' + CAST(C.MontoMinimoPedido AS VARCHAR(15)) 
																WHEN 'OCC-17' THEN 'MÁXIMO: ' + CAST(C.MontoMaximoPedido AS VARCHAR(15)) 				
																WHEN 'OCC-19' THEN 'DEUDA: ' + CAST(P1.Valor AS VARCHAR(15)) 				
																WHEN 'OCC-51' THEN 'MINIMO STOCK' END   AS VARCHAR(MAX))		
										 FROM GPR.PedidoRechazado P1		
										 INNER JOIN GPR.MotivoRechazo MR 
											ON P1.MotivoRechazo = MR.Codigo
										 WHERE pr.idprocesopedidorechazado = p1.idprocesopedidorechazado 
										 AND p1.codigoconsultora=pr.codigoconsultora 
										 AND p1.campania=pr.campania 
										 AND p.GPRSB = 2  
										 AND P1.Procesado = 1										 		
										 AND p1.idprocesopedidorechazado=IDPROCESORECHAZO.IDPROCESO 
							FOR XML PATH ('')), 1, 1, '')) END AS MotivoRechazo,
						p.EstadoPedido,
						p.GPRSB
				FROM dbo.PedidoWeb p (NOLOCK)
				INNER JOIN ods.Consultora c (NOLOCK) on p.consultoraid = c.consultoraid
				INNER JOIN ods.Region r (NOLOCK) on c.regionid = r.regionid
				INNER JOIN ods.Zona z (NOLOCK) on r.regionid = z.regionid 
											   and c.zonaid = z.zonaid
				INNER JOIN ods.Seccion s (NOLOCK) on c.seccionid = s.seccionid 
												  and r.regionid = s.regionid 
												  and z.zonaid = s.zonaid
				LEFT JOIN GPR.PedidoRechazado PR (NOLOCK) ON c.codigo = pr.CodigoConsultora 
														  AND CAST(pr.Campania AS INT) = @WebCampaniaID 
														  AND PR.PROCESADO=1

				--EDP-2766
				LEFT JOIN TableIdProcesoRechazo IDPROCESORECHAZO ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
																AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
																AND PR.Campania=P.CAMPANIAID 	
					
				--LEFT JOIN (SELECT PR1.CODIGOCONSULTORA,
				--				  MAX(_PR.IDPROCESOPEDIDORECHAZADO) IDPROCESO 
				--		   FROM GPR.PROCESOPEDIDORECHAZADO _PR 
				--		   INNER JOIN GPR.PEDIDORECHAZADO PR1 ON _PR.IDPROCESOPEDIDORECHAZADO=PR1.IDPROCESOPEDIDORECHAZADO
				--		   WHERE PR1.CAMPANIA=@WebCampaniaID  
				--		   GROUP BY PR1.CODIGOCONSULTORA
				--		  ) IDPROCESORECHAZO
				--	ON PR.IDPROCESOPEDIDORECHAZADO=IDPROCESORECHAZO.IDPROCESO 
				--	AND IDPROCESORECHAZO.CODIGOCONSULTORA=C.CODIGO
				--	AND PR.Campania=P.CAMPANIAID 	
				WHERE (@WebCampaniaID is null or p.CampaniaID = @WebCampaniaID) 
				AND p.ImporteTotal <> 0  
				AND(@WebEsRechazado = 2  
					OR (@WebEsRechazado = 1 
						AND p.GPRSB = 2) 
					OR (@WebEsRechazado = 0 
						AND p.GPRSB <> 2 ))
				AND (@WebEstadoPedido = 0 
					OR @WebEstadoPedido = (CASE WHEN p.EstadoPedido = 202 
													AND p.ValidacionAbierta = 0 
													AND p.ModificaPedidoReservadoMovil = 0  
												THEN 202
											ELSE 201	
											END )
					)
				AND (@WebRegionCodigo = '0' 
					OR @WebRegionCodigo is null 
					OR r.Codigo = @WebRegionCodigo)
				AND (@WebZonaCodigo = '0' 
					OR @WebZonaCodigo is null 
					OR z.Codigo = @WebZonaCodigo)
				AND (@WebCodigoConsultora = '' 
					OR c.Codigo like '%' + @WebCodigoConsultora + '%')		
			
		)			
				
		Insert into #TempTablePedidoNoFact
		(
		   PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo
		)
		select PedidoID,
	       FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
	       Zona,
		   Seccion,
		   ConsultoraCodigo,
	       ConsultoraNombre,
		   DescuentoProl,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo		   
		From PreTablePedidosWebNoFacturados
		where 1=1
		and motivorechazo is not null
		--and (motivorechazo is not null and rtrim(ltrim(motivorechazo)) <> '')
		
		----and isnull(motivorechazo,0) <> 0 
		--where isnull(MotivoRechazo,0) = 0 

	END -- Second If

	Select ROW_NUMBER() OVER(ORDER BY FechaRegistro DESC) AS NroRegistro,
		   PedidoID,
		   FechaRegistro,
		   FechaReserva,
		   CampaniaCodigo,
		   Zona,
		   Seccion,
		   ConsultoraCodigo,
		   ConsultoraNombre,
		   DescuentoProl,
		   ImporteTotal,
		   ConsultoraSaldo,
		   OrigenNombre,
		   EstadoValidacionNombre,
		   Region,
		   IndicadorEnviado,
		   MontoMinimoPedido,
		   ImporteTotalMM,
		   UsuarioResponsable,
		   MotivoRechazo,		
		   @DDPrefijoPais PaisISO --DICC 07062017
		   from #TempTablePedidoNoFact
		   
	Drop Table #TempTablePedidoNoFact

END

GO
