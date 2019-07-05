﻿use [BelcorpBolivia]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go




use [BelcorpChile]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go





use [BelcorpColombia]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go



use [BelcorpCostaRica]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go




use [BelcorpDominicana]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go




use [BelcorpEcuador]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go



use [BelcorpGuatemala]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 

CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go



use [BelcorpMexico]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go



use [BelcorpPanama]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go



use [BelcorpPeru]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go




use [BelcorpPuertoRico]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go




use [BelcorpSalvador]	
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigitalRecibe]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigitalRecibe
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, RecogerNombre NombresRecepcionPedido,RecogerDNI DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, RecogerNombre=NULL, RecogerDNI=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END
go


