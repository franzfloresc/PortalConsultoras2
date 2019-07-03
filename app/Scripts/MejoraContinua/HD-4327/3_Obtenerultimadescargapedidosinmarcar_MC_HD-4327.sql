use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go

  use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenerultimadescargapedidosinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenerultimadescargapedidosinmarcar]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
Obtenerultimadescargapedidosinmarcar '201909'
*/ 
CREATE PROCEDURE [DBO].[Obtenerultimadescargapedidosinmarcar] 
@campaniaid      INT
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
      DECLARE @NROLOTE AS INT 
      DECLARE @NROPEDIDOSWEB AS INT 
      DECLARE @NROPEDIDOSDD AS INT 
      DECLARE @TIPOCRONOGRAMA AS INT 

	  set @ESTADOPROCESO=0
      -- OBTENER EL NROLOTE DE LA ULTIMA DESCARGA. 
      SELECT TOP 1 @NROLOTE = NROLOTE, 
                   @TIPOCRONOGRAMA = TIPOCRONOGRAMA 
      FROM   PEDIDODESCARGASINMARCAR 
	  WHERE CampanaId=@campaniaid
      ORDER  BY FECHAINICIO DESC 

      -- OBTENER LA CANTIDAD DE PEDIDOS WEB Y DD. 
      SELECT @NROPEDIDOSWEB = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'W' 

      SELECT @NROPEDIDOSDD = COUNT(*) 
      FROM   LOGCARGAPEDIDOSINMARCAR 
      WHERE  NROLOTE = @NROLOTE 
	  AND CAMPANIAID=@campaniaid
             AND ORIGEN = 'D' 



	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=isnull(ESTADO,0) FROM pedidodescargavalidador
	END


      SELECT FECHAINICIO    AS FECHAHORAINICIO,
             FECHAFIN       AS FECHAHORAFIN, 
             CASE 
               WHEN ESTADO = 1 THEN 'TERMINADO' 
               WHEN ESTADO = 2 THEN 'CON ERROR' 
               WHEN ESTADO = 0THEN 'EN PROCESO' 
             END            AS ESTADO, 
             MENSAJE, 
             @NROPEDIDOSWEB AS NUMEROPEDIDOSWEB, 
             @NROPEDIDOSDD  AS NUMEROPEDIDOSDD, 
             CAMPANAID      AS CAMPANAID, 
             NROLOTE ,
			 @ESTADOPROCESO ESTADOPROCESOGENERAL
      FROM   PEDIDODESCARGASINMARCAR 
      WHERE  NROLOTE = @NROLOTE 

	   

  END 

  go