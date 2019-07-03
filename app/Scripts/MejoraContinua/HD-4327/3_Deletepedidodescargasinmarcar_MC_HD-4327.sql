use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO

  use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpMexico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO


use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Deletepedidodescargasinmarcar]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Deletepedidodescargasinmarcar]
GO
/*       
CREADO POR  : PAQUIRRI SEPERAK       
FECHA : 24/06/2019       
DESCRIPCIÓN : REGISTRA LOS PEDDISO SIN MARCAR   
*/ 
CREATE PROCEDURE dbo.Deletepedidodescargasinmarcar 
@NROLOTE INT ,
@NUEVONROLOTE INT ,
@VALOR VARCHAR(6),
@CAMPANIAID     INT, 
@USUARIO        VARCHAR(20)
AS 
  BEGIN 
   IF (@VALOR!='bb') BEGIN
      /*CABECERA*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDOSINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDOSINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 

      /*DETALLE*/ 
      IF EXISTS (SELECT 1 
                 FROM   LOGCARGAPEDIDODETALLESINMARCAR 
                 WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID) 
        BEGIN 
            DELETE LOGCARGAPEDIDODETALLESINMARCAR 
            WHERE  NROLOTE = @NROLOTE and CodigoUsuarioProceso=@USUARIO AND Campaniaid=@CAMPANIAID
        END 
  END

	/*ELIMINAMOS LA TABLA SEMÁFORO*/
	IF (@VALOR='bb') BEGIN
	DELETE FROM PEDIDODESCARGASINMARCAR WHERE NROLOTE=@NUEVONROLOTE
	DELETE FROM pedidodescargavalidador
	END


	UPDATE pedidodescargavalidador SET NroLote=@NUEVONROLOTE,CampanaId= @CAMPANIAID,Estado=0  , FechaProceso=GETDATE(), Usuario=@USUARIO


  END 

  GO
