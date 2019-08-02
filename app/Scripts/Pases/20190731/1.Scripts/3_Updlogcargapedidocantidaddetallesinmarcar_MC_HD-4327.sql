use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go

use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Updlogcargapedidocantidaddetallesinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Updlogcargapedidocantidaddetallesinmarcar]
GO
/*        
CREADO POR  : PAQUIRRI SEPERAK        
FECHA : 24/06/2019        
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
*/ 
CREATE PROCEDURE Updlogcargapedidocantidaddetallesinmarcar (@NROLOTE INT) 
AS 
    UPDATE LOGCARGAPEDIDOSINMARCAR 
    SET    CANTIDAD = (SELECT COUNT(PD.CANTIDAD) 
                       FROM   LOGCARGAPEDIDODETALLESINMARCAR PD 
                       WHERE  PD.CAMPANIAID = PH.CAMPANIAID 
                              AND PD.NROLOTE = PH.NROLOTE 
                              AND PD.PEDIDOID = PH.PEDIDOID) 
    FROM   LOGCARGAPEDIDOSINMARCAR PH 
    WHERE  PH.NROLOTE = @NROLOTE 

go