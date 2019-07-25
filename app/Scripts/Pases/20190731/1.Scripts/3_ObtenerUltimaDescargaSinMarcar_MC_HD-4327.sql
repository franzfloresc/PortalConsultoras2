use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
  use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaSinMarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : RETORNA EL ESTADO DE LA TABLA SEMÁFORO
ObtenerUltimaDescargaSinMarcar 
*/ 
CREATE PROCEDURE [DBO].[ObtenerUltimaDescargaSinMarcar] 
AS 
  BEGIN 
  IF( (SELECT COUNT(1)FROM pedidodescargavalidador )  > 0) BEGIN
  SELECT CampanaId CampaniaId,case when  Estado =1 then 'En Proceso'  else 'Cerrado' end   DescripcionEstadoProcesoGeneral ,FechaProceso FechaProceso  FROM pedidodescargavalidador
  END
  ELSE
  BEGIN
  SELECT '-' CampaniaId,'Sin ejecución' DescripcionEstadoProcesoGeneral , null FechaProceso
  END
  END
  go
  
