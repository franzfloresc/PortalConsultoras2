USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpChile
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.UpdCantidadPedidoWebSet', 'P') IS NOT NULL
	DROP PROC dbo.UpdCantidadPedidoWebSet
	GO
CREATE PROCEDURE dbo.UpdCantidadPedidoWebSet  
                @SetId int,  
                @Cantidad int  
AS  
--Cabecera
 UPDATE dbo.PedidoWebSet
 SET Cantidad = @Cantidad
      , ImporteTotal = (@Cantidad * PrecioUnidad)
 WHERE SetId = @SetId  
 --Detalle
  UPDATE dbo.PedidoWebSetDetalle  
  SET Cantidad = @Cantidad * FactorRepeticion  
  WHERE SetId = @SetId  
GO



