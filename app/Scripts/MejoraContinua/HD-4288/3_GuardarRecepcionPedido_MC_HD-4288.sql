USE [BelcorpBolivia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpChile] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpColombia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpCostaRica] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpDominicana] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpEcuador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpGuatemala] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpMexico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpPanama] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpPeru] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpPuertoRico] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE [BelcorpSalvador] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[GuardarRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[GuardarRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
GuardarRecepcionPedido 'E','E', 9521388 
*/ 
CREATE PROCEDURE Guardarrecepcionpedido @NombreYApellido VARCHAR(512), 
                                        @NumeroDocumento VARCHAR(512), 
                                        @PedidoID        INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    recogernombre = @NombreYApellido, 
             recogerdni = @NumeroDocumento, 
             indicadorrecepcion = 1 
      WHERE  pedidoid = @PedidoID 
  END 

go 