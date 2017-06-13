--Rollback from Production 13/06/2017
Use BelcorpBolivia
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]

@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID		
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC



GO


Use BelcorpChile
go

ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV,
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


Use BelcorpColombia
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC



GO


Use BelcorpCostaRica
go

ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


Use BelcorpDominicana
go

ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


Use BelcorpEcuador
go

aLTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC



GO


Use BelcorpGuatemala
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC



GO


Use BelcorpMexico
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


Use BelcorpPanama
go

ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  AS 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


Use BelcorpPeru
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'--'OBSERVADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC	



GO


Use BelcorpPuertoRico
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


use BelcorpSalvador
go



ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC


GO


use BelcorpVenezuela
go


ALTER PROCEDURE [dbo].[GetCDRWebDetalleReporte]
@CampaniaID INT,
@RegionID INT,
@ZonaID INT,
@ConsultoraCodigo VARCHAR(25),
@EstadoCDR INT
AS

SELECT RIGHT('00000' +  convert(varchar(10),a.CDRWebID),5) AS NroCDR, 
c.Codigo as ConsultoraCodigo, z.Codigo as ZonaCodigo,
r.Codigo as RegionCodigo, s.Codigo as SeccionCodigo,
cast(a.CampaniaID as varchar(6)) as CampaniaOrigenPedido,
ISNULL(CONVERT(VARCHAR(20),a.FechaRegistro,103) + ' ' + CONVERT(VARCHAR(20),a.FechaRegistro,108),'') as FechaHoraSolicitud,
ISNULL(CONVERT(VARCHAR(20),a.FechaAtencion,103) + ' ' + CONVERT(VARCHAR(20),a.FechaAtencion,108),'') as  FechaAtencion,
'EstadoDescripcion' = CASE WHEN a.Estado = 1 THEN 'PENDIENTE'
								WHEN a.Estado = 2 THEN 'EN EVALUACIÓN'
								WHEN a.Estado = 3 THEN 'APROBADO'
								WHEN a.Estado = 4 THEN 'CON OBSERVACIONES' END,
b.CUV, 
d.Cantidad as UnidadesFacturadas,
--d.MontoPagar as MontoFacturado,
'MontoFacturado' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2), pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END,
b.Cantidad as UnidadesDevueltas,
'MontoDevuelto' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T'))  THEN CONVERT(DECIMAL(18,2),pd.ImporteTotal) ELSE CONVERT(DECIMAL(18,2),d.MontoPagar) END * b.Cantidad,
b.CUV2 as CodigoProductoEnviar,
b.Cantidad2 as UnidadesEnviar,
'MontoProductoEnviar' = CASE WHEN b.CodigoOperacion = LTRIM(RTRIM('T')) 
							THEN CONVERT(DECIMAL(18,2),(pc.PrecioCatalogo * pc.FactorRepeticion * b.Cantidad2))
						WHEN b.CodigoOperacion = LTRIM(RTRIM('C')) THEN CONVERT(DECIMAL(18,2),d.MontoPagar * b.Cantidad / d.Cantidad) ELSE CONVERT(DECIMAL(18,2),0) END,
						b.CodigoOperacion,
						o.DescripcionOperacion AS 'Operacion',
						--m.DescripcionReclamo,	
						mo.Descripcion as Reclamo,
'EstadoDetalle' = CASE WHEN b.Estado = 1 THEN 'PENDIENTE'
					WHEN b.Estado = 2 THEN 'EN EVALUACIÓN'
					WHEN b.Estado = 3 THEN 'APROBADO'
					WHEN b.Estado = 4 THEN 'RECHAZADO'
					END,
CASE WHEN (select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo) = NULL then ISNULL(b.Observacion, '') 
						 ELSE isnull((select Descripcion from Cdrwebdescripcion where CodigoSSIC=b.MotivoRechazo),'') END  as 'MotivoRechazo',
r.RegionID			
FROM CDRWeb	a
INNER JOIN CDRWebDetalle b ON
a.CDRWebID = b.CDRWebID
INNER JOIN ods.Consultora c ON
a.ConsultoraID = c.ConsultoraID
INNER JOIN ods.Zona z ON
c.ZonaID = z.ZonaID
INNER JOIN ods.Region r ON
c.RegionID = R.RegionID
INNER JOIN ods.Seccion s ON
c.SeccionID = s.SeccionID
INNER JOIN ods.TipoOperacionesCDR o ON
b.CodigoOperacion = O.CodigoOperacion
--INNER JOIN ods.MotivoReclamoCDR m ON
--m.CodigoReclamo = b.CodigoReclamo
INNER JOIN (select  CodigoSSIC, Descripcion from CDRWebDescripcion where Tipo ='motivo') mo ON
mo.CodigoSSIC = b.CodigoReclamo
LEFT JOIN ods.ProductoComercial pc ON
b.CUV2 = pc.CUV AND
a.CampaniaID = pc.AnoCampania
INNER JOIN ods.PedidoDetalle d ON 
b.CUV = d.CUV AND
a.PedidoID = d.PedidoID
INNER JOIN PedidoWebDetalle pd on
a.CampaniaID = pd.CampaniaID AND
a.ConsultoraID = pd.ConsultoraID AND
b.CUV = pd.CUV
WHERE b.Eliminado = 0 AND
a.CampaniaID = @CampaniaID AND
(c.RegionID = @RegionID OR 0 = @RegionID) AND
(c.ZonaID = @ZonaID OR 0 = @ZonaID) AND
(LTRIM(RTRIM(c.Codigo)) = LTRIM(RTRIM(@ConsultoraCodigo)) OR '' = @ConsultoraCodigo) AND
(b.Estado = @EstadoCDR OR 0 = @EstadoCDR)
ORDER BY a.CDRWebID ASC



GO


