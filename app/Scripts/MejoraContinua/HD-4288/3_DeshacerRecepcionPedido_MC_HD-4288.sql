USE [BelcorpBolivia] 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpchile 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpcolombia 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpcostarica 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpdominicana 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpecuador 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpguatemala 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpmexico 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorppanama 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpperu 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorppuertorico 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 

USE belcorpsalvador 

go 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[DeshacerRecepcionPedido]') 
                  AND type IN ( N'P', N'PC' )) 
  DROP PROCEDURE [dbo].[DeshacerRecepcionPedido] 

go 

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 04/06/2019    
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS  
DeshacerRecepcionPedido  
*/ 
CREATE PROCEDURE Deshacerrecepcionpedido @PedidoID INT 
AS 
  BEGIN 
      UPDATE pedidoweb 
      SET    indicadorrecepcion = 0, 
             recogernombre = NULL, 
             recogerdni = NULL 
      WHERE  pedidoid = @PedidoID 
  END 

go 