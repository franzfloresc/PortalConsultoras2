USE BelcorpBolivia
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE GetCDRWebDetalleReporte
	@CampaniaID INT,
	@RegionID INT,
	@ZonaID INT,
	@ConsultoraCodigo VARCHAR(25),
	@EstadoCDR INT,
	@TipoConsultora INT = NULL
AS
BEGIN
	SELECT
		RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
		c.Codigo as ConsultoraCodigo,
		z.Codigo as ZonaCodigo,
		r.Codigo as RegionCodigo,
		s.Codigo as SeccionCodigo,
		cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
		ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
		ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
		CASE
			WHEN a.Estado = 1 THEN 'PENDIENTE'
			WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN a.Estado = 3 THEN 'APROBADO'
			WHEN a.Estado = 4 THEN 'CON OBSERVACIONES'
		END as EstadoDescripcion,
		b.CUV,
		d.Cantidad as UnidadesFacturadas,
		--d.MontoPagar as MontoFacturado,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END as MontoFacturado,
		b.Cantidad as UnidadesDevueltas,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal)
			ELSE CONVERT(DECIMAL(18,2),d.MontoPagar)
		END * b.Cantidad as MontoDevuelto,
		b.CUV2 as CodigoProductoEnviar,
		b.Cantidad2 as UnidadesEnviar,
		CASE
			WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
			WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad)
			ELSE CONVERT(DECIMAL(18,2),0)
		END as MontoProductoEnviar,
		b.CodigoOperacion,
		o.DescripcionOperacion as Operacion,
		--m.DescripcionReclamo,	
		mo.Descripcion as Reclamo,
		CASE
			WHEN b.Estado = 1 THEN 'PENDIENTE'
			WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
			WHEN b.Estado = 3 THEN 'APROBADO'
			WHEN b.Estado = 4 THEN 'RECHAZADO'
		END as EstadoDetalle,
		CASE
			WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
			ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'')
		END as MotivoRechazo,
		r.RegionID,
		iif(isnull(c.ConsecutivoNueva,0) = 0, 'Otros', concat(c.ConsecutivoNueva,'d6')) as TipoConsultora,
		iif(isnull(a.TipoDespacho,0) = 1,'Express','Regular') as TipoDespacho,
		isnull(a.FleteDespacho,0.00) as FleteDespacho
	FROM CDRWeb	a
	INNER JOIN CDRWebDetalle b ON a.CDRWebID = b.CDRWebID
	INNER JOIN ods.Consultora c ON a.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r ON c.RegionID = R.RegionID
	INNER JOIN ods.Seccion s ON c.SeccionID = s.SeccionID
	INNER JOIN ods.TipoOperacionesCDR o ON b.CodigoOperacion = O.CodigoOperacion
	--INNER JOIN ods.MotivoReclamoCDR m ON m.CodigoReclamo = b.CodigoReclamo
	INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON mo.CodigoSSIC = b.CodigoReclamo
	LEFT JOIN ods.ProductoComercial pc ON b.CUV2 = pc.CUV AND a.CampaniaID = pc.AnoCampania
	INNER JOIN ods.PedidoDetalle d ON b.CUV = d.CUV AND a.PedidoID = d.PedidoID
	INNER JOIN PedidoWebDetalle pd on a.CampaniaID = pd.CampaniaID AND a.ConsultoraID = pd.ConsultoraID AND b.CUV = pd.CUV
	WHERE
		b.Eliminado = 0 AND
		a.CampaniaID = @CampaniaID AND
		(c.RegionID = @RegionID OR 0 = @RegionID) AND
		(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
		(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
		(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
		AND (
			isnull(@TipoConsultora,0) = 0
			or (@TipoConsultora = 1 and c.ConsecutivoNueva = 0)
			or (@TipoConsultora = 2 and c.ConsecutivoNueva > 0) 	  
		)
	ORDER BY a.CDRWebID ASC;
END
GO