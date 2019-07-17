USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetTrackingPedidoByConsultora 
@CodigoConsultora VARCHAR(15),  
@Top INT = 3  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @TBL_PEDIDO TABLE  
 (  
  NumeroPedido VARCHAR(50) NOT NULL,  
  Campana INT NOT NULL,  
  StatusEntrega VARCHAR(50) NULL,  
  FechaDigitado DATETIME NOT NULL,  
  Facturado DATETIME NULL,  
  EnArmado DATETIME NULL,  
  Chequeado DATETIME NULL,  
  Despachado DATETIME NULL,  
  FechaEstimada DATETIME NULL,  
  Recibido DATETIME NULL,  
  FechaEstimadaDesde DATETIME NULL,  
  FechaEstimadaHasta DATETIME NULL,    
  PRIMARY KEY(NumeroPedido, Campana)  
 )  
  
 INSERT INTO @TBL_PEDIDO  
 (  
  NumeroPedido,  
  Campana,  
  StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta
 )  
 SELECT TOP (@Top)  
  NroPedido,  
  Campana,  
  CASE WHEN CONVERT(varchar(8),Recibido,112) <> '20010101' THEN   
   CASE WHEN CONVERT(varchar(8),Recibido,112) = '20100101' or  CONVERT(varchar(8),Recibido,112) = '20100102' THEN   
    IIF (CONVERT(varchar(8),Recibido,112) = '20100101', 'ENTREGADO', 'NO ENTREGADO' )   
       ELSE 'ENTREGADO' END ELSE  
         CASE WHEN NOT Despachado IS NULL THEN 'EN TRANSPORTE' ELSE  
        CASE WHEN NOT Chequeado IS NULL THEN 'EN CHEQUEO' ELSE  
          CASE WHEN NOT EnArmado IS NULL THEN 'EN ARMADO' ELSE  
         CASE WHEN NOT Facturado IS NULL THEN 'SIN ARMAR' ELSE  
           CASE WHEN NOT FechaDigitado IS NULL THEN 'PENDIENTE A FACTURAR' ELSE NULL  
           END  
         END  
          END  
        END  
         END  
       END AS StatusEntrega,  
  FechaDigitado,  
  Facturado,  
  EnArmado,  
  Chequeado,  
  Despachado,  
  FechaEstimada,  
  Recibido,
  FechaEstimadaDesde,
  FechaEstimadaHasta   
 FROM dbo.vwTracking  
 WHERE Consultora = @CodigoConsultora  
 AND NroPedido IS NOT NULL  
 ORDER BY Campana DESC, FechaDigitado DESC  
  
 SELECT   
  NumeroPedido,  
  Campana,  
  StatusEntrega AS Estado,  
  Facturado AS Fecha  
 FROM @TBL_PEDIDO  
  
 SELECT   
  T.Campana,  
  T.NumeroPedido,  
  G.ID AS Etapa,  
  G.Situacion,  
  CASE G.ID   
   WHEN 1 THEN T.FechaDigitado  
   WHEN 2 THEN T.Facturado  
   WHEN 3 THEN T.EnArmado  
   WHEN 4 THEN T.Chequeado  
   WHEN 5 THEN T.Despachado  
   WHEN 6 THEN T.FechaEstimada  
   WHEN 7 THEN  
    CASE WHEN NOT T.Despachado IS NULL  
		THEN T.Recibido 
	ELSE NULL END  
   WHEN 8 THEN T.FechaEstimadaDesde
   WHEN 9 THEN T.FechaEstimadaHasta
  END AS Fecha  
 FROM @TBL_PEDIDO T  
 INNER JOIN vwSituacionPedido G  
 ON 1 = 1  
 WHERE G.ID <> 4
 ORDER BY T.Campana, T.FechaDigitado,G.ORDEN, G.ID  
  
 SET NOCOUNT OFF  
END 

GO