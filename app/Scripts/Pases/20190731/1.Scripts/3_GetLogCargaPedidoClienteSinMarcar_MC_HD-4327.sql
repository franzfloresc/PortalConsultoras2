use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go

  use BelcorpChile	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpColombia	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpCostaRica	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpDominicana	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpEcuador	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpGuatemala	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpMexico	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpPanama	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpPeru	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpPuertoRico	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go


use BelcorpSalvador	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetLogCargaPedidoClienteSinMarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetLogCargaPedidoClienteSinMarcar]
GO
/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 24/06/2019    
DESCRIPCIÓN : CARGA LOS PEDIDOS DEL CLIENTE 
GetLogCargaPedidoClienteSinMarcar 20


*/ 
CREATE PROCEDURE dbo.GetLogCargaPedidoClienteSinMarcar 
@NROLOTE INT 
AS 
  BEGIN 
      SET NOCOUNT ON 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO                               CODIGOCONSULTORA, 
             P.CLIENTES, 
             R.CODIGO                               CODIGOREGION, 
             Z.CODIGO                               CODIGOZONA, 
             IIF(P.ESTADOPEDIDO = 202 
                 AND P.VALIDACIONABIERTA = 0, 1, 0) AS VALIDADO ,
			convert(varchar(64),L.FECHACARGA,112) FECHACARGA,
			L.IPUsuario,
			L.TipoCupon,
			L.ValorCupon
      FROM   LOGCARGAPEDIDOSINMARCAR L 
             INNER JOIN DBO.PEDIDOWEB P WITH(NOLOCK) 
                     ON P.CAMPANIAID = L.CAMPANIAID 
                        AND P.PEDIDOID = L.PEDIDOID 
             JOIN ODS.CONSULTORA C WITH(NOLOCK) 
               ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.REGION R WITH(NOLOCK) 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA Z WITH(NOLOCK) 
                     ON C.ZONAID = Z.ZONAID 
      WHERE  L.NROLOTE = @NROLOTE; 

      SELECT P.PEDIDOID, 
             P.CAMPANIAID, 
             C.CODIGO        CODIGOCONSULTORA, 
             P.CUV           AS CODIGOVENTA, 
             P.CUV           AS CODIGOPRODUCTO, 
             SUM(P.CANTIDAD) AS CANTIDAD 
      FROM   LOGCARGAPEDIDODETALLESINMARCAR P 
             INNER JOIN PEDIDOWEBDETALLE PK 
                     ON P.CAMPANIAID = PK.CAMPANIAID 
                        AND P.PEDIDOID = PK.PEDIDOID 
             INNER JOIN ODS.CONSULTORA C WITH(NOLOCK) 
                     ON PK.CONSULTORAID = C.CONSULTORAID 
      -- INNER JOIN ODS.PRODUCTOCOMERCIAL PR WITH(NOLOCK) ON P.CAMPANIAID = PR.CAMPANIAID AND P.CUV = PR.CUV
      WHERE  P.NROLOTE = @NROLOTE 
             AND ISNULL(PK.PEDIDODETALLEIDPADRE, 0) = 0 
      GROUP  BY P.CAMPANIAID, 
                P.PEDIDOID, 
                C.CODIGO, 
                P.CUV 
      HAVING SUM(P.CANTIDAD) > 0; 

      SET NOCOUNT OFF 
  END 
  go
