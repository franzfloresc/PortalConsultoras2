use [BelcorpBolivia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpChile]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpColombia]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpCostaRica]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpDominicana]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpEcuador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpGuatemala]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpMexico]		
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpPanama]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpPeru]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpPuertoRico]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go

  use [BelcorpSalvador]	
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerultimaLlamadaPedidodescargavalidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ObtenerultimaLlamadaPedidodescargavalidador]
GO
/*            
CREADO POR  : PAQUIRRI SEPERAK            
FECHA : 24/06/2019            
DESCRIPCIÓN : ACTUALIZA LA CANTIDAD DE PEDIDOS 
ObtenerultimaLlamadaPedidodescargavalidador 
*/ 
CREATE PROCEDURE [DBO].[ObtenerultimaLlamadaPedidodescargavalidador] 
AS 
  BEGIN 
      DECLARE @ESTADOPROCESO AS INT
    
	IF	EXISTS (SELECT * FROM pedidodescargavalidador  WHERE ESTADO=1)
	BEGIN
	SELECT @ESTADOPROCESO=ESTADO FROM pedidodescargavalidador
	END

	SELECT isnull(@ESTADOPROCESO,0) EstadoProcesoGeneral


  END 
  go