USE [BelcorpBolivia]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

USE [BelcorpChile]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

go

USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

go

USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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
USE [BelcorpDominicana]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

go

USE [BelcorpEcuador]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
Alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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
USE [BelcorpGuatemala]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

go

USE [BelcorpMexico]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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
go

USE [BelcorpPanama]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

go

USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

USE [BelcorpPuertoRico]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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
USE [BelcorpSalvador]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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
go

USE [BelcorpVenezuela]
GO
/****** Object:  StoredProcedure [dbo].[GetCDRWebDetalleReporte]    Script Date: 8/05/2017 10:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
alter PROCEDURE [dbo].[GetCDRWebDetalleReporte]
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
					WHEN b.Estado = 4 THEN 'OBSERVADO'
					END,
ISNULL(b.Observacion,'') as 'MotivoRechazo',r.RegionID
						
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

