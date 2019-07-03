use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO


use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcarDD]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcarDD]
GO
/*     
CREADO POR  : PAQUIRRI SEPERAK     
FECHA : 24/06/2019     
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE  
*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcarDD 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO CODIGOCONSULTORA, 
             --0 CLIENTES,  
             R.CODIGO CODIGOREGION, 
             Z.CODIGO CODIGOZONA--, 
      --IIF(P.ESTADOPEDIDO = 202 AND P.VALIDACIONABIERTA = 0,1,0) AS VALIDADO 
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDODD P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN DBO.PEDIDODDDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0 

      SET NOCOUNT OFF 
  END 
GO

