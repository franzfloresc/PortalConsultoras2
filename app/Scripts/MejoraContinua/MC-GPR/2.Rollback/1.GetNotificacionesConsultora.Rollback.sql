USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNotificacionesConsultora]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetNotificacionesConsultora]
GO


CREATE PROCEDURE dbo.GetNotificacionesConsultora
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
declare @Temporal table
(
ProcesoId bigint,
CampaniaId int,
EstadoPROL varchar(2),
FechaHoraValidación datetime,
EnvioCorreo bit,
Proceso varchar(20),
Estado int,
Observaciones varchar(500),
FechaFacturacion date,
Asunto varchar(500),
FacturaHoy bit,
Visualizado bit,
EsMontoMinino bit,
FlagProcedencia bit,
RowsCount int
);
insert into @Temporal
select
SolicitudClienteID as ProcesoId,
Campania as CampaniaId,
'' as EstadoPROL,
FechaSolicitud as FechaHoraValidación,
cast(1 as bit) as EnvioCorreo,
'BUSCACONS' as Proceso,
IIF(Estado IS NULL, 0, 1) as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
cast(0 as bit) as FacturaHoy,
Leido as Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as 'FlagProcedencia',
1
from SolicitudCliente
where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))
UNION ALL
select
S.SolicitudClienteCatalogoID as ProcesoId,
S.Campania as CampaniaId,
'' as EstadoPROL,
S.FechaRegistro as FechaHoraValidación,
cast(0 as bit) as EnvioCorreo,
'CATALOGO' as Proceso,
1 as Estado,
'' as Observaciones,
GETDATE() as FechaFacturacion,
S.AsuntoNotificacion as Asunto,
cast(0 as bit) as FacturaHoy,
S.Visualizado AS Visualizado,
cast(0 as bit) as EsMontoMinino,
1 as FlagProcedencia,
1
from SolicitudClienteCatalogo S
INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId AND S.CodigoConsultora = C.Codigo
UNION ALL
SELECT *
FROM
(SELECT
LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId, --LogGPRValidacionId
ISNULL(LGPRV.Campania, '201601') AS CampaniaId,
'' AS EstadoPROL,
LGPRV.FechaFinValidacion AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'PEDREC' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LGPRV.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
FROM GPR.LogGPRValidacion LGPRV
WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
as rows
where row_number = 1
IF(@ShowCDR = 1)
BEGIN
insert into @Temporal
SELECT
LCDRW.LogCDRWebId AS ProcesoId,
LCDRW.CampaniaId,
'' AS EstadoPROL,
LCDRW.FechaAtencion AS FechaHoraValidación,
LCDRW.EnvioCorreo,
'CDR' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRW.Visualizado AS Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
UNION ALL
SELECT
LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
LCDRWC.CampaniaId,
'' AS EstadoPROL,
LCDRWC.FechaCulminado AS FechaHoraValidación,
CAST(0 AS BIT) as EnvioCorreo,
'CDR-CULM' AS Proceso,
1 AS Estado,
'' AS Observaciones,
GETDATE() AS FechaFacturacion,
'CDR: REGISTRADO' AS Asunto,
CAST(0 AS BIT) AS FacturaHoy,
LCDRWC.Visualizado,
CAST(0 AS BIT) AS EsMontoMinino,
1 AS FlagProcedencia,
1
FROM dbo.LogCDRWebCulminado LCDRWC
WHERE LCDRWC.ConsultoraId = @ConsultoraId;
END
select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
from @Temporal
order by FechaHoraValidación desc;
END

GO

