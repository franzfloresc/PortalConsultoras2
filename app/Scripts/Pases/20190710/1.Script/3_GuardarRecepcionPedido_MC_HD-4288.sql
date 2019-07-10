use [BelcorpBolivia]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO



use [BelcorpChile]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO




use [BelcorpColombia]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO




use [BelcorpCostaRica]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO




use [BelcorpDominicana]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO




use [BelcorpEcuador]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO




use [BelcorpGuatemala]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


use [BelcorpMexico]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


use [BelcorpPanama]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


use [BelcorpPeru]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


use [BelcorpPuertoRico]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


use [BelcorpSalvador]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET RecogerNombre=@NombreYApellido, RecogerDNI=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END
GO


