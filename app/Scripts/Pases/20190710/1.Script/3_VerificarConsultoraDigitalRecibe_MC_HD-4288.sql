USE [BelcorpBolivia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpChile] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpColombia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpCostaRica] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpDominicana] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpEcuador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpGuatemala] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpMexico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpPanama] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpPeru] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpPuertoRico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 

USE [BelcorpSalvador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = 
                  Object_id(N'[dbo].[VerificarConsultoraDigitalRecibe]' 
                  ) 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[VerificarConsultoraDigitalRecibe] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO  
VerificarConsultoraDigitalRecibe '023499290', 9521388 
*/ 
CREATE PROCEDURE Verificarconsultoradigitalrecibe @CodigoConsultora VARCHAR(64), 
                                                  @PedidoID         INT 
AS 
  BEGIN 
      DECLARE @IndicadorConsultoraDigital INT 

      IF( (SELECT Count(1) 
           FROM   ods.consultora C 
                  INNER JOIN pedidoweb P 
                          ON C.consultoraid = P.consultoraid 
           WHERE  C.codigo = @CodigoConsultora 
                  AND P.pedidoid = @PedidoID) > 0 ) 
        BEGIN 
            SELECT indicadorrecepcion, 
                   recogernombre NombresRecepcionPedido, 
                   recogerdni    DNIRecepcionPedido, 
                   indicadorconsultoradigital 
            FROM   ods.consultora C 
                   INNER JOIN pedidoweb P 
                           ON C.consultoraid = P.consultoraid 
            WHERE  C.codigo = @CodigoConsultora 
                   AND P.pedidoid = @PedidoID 
        END 
      ELSE 
        BEGIN 
            UPDATE pedidoweb 
            SET    indicadorrecepcion = 0, 
                   recogernombre = NULL, 
                   recogerdni = NULL 
            WHERE  pedidoid = @PedidoID 

            SELECT @IndicadorConsultoraDigital = indicadorconsultoradigital 
            FROM   ods.consultora 
            WHERE  codigo = @CodigoConsultora 

            SELECT NULL, 
                   NULL, 
                   NULL, 
                   @IndicadorConsultoraDigital IndicadorConsultoraDigital 
        END 
  END 

go 