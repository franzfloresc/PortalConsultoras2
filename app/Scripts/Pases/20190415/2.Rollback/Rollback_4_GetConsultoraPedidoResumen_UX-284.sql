USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetConsultoraPedidoResumen', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConsultoraPedidoResumen AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetConsultoraPedidoResumen] (  
 @consultoraId INT  
 ,@codigoCampania INT  
 )  
AS  
-- exec [GetConsultoraPedidoResumen] 50271415, 201711  
BEGIN  
 DECLARE @CantidadclientesPedido INT;  
  
 --Clientes  
 SELECT count(*) AS CantidadClientes  
 FROM Cliente c  
 WHERE c.ConsultoraId = @consultoraId  
  AND c.Activo = 1;  
  
 --Cobra Deudas  
 WITH Cliente_Deuda(ClienteId, TotalDeuda) AS (  
   SELECT cm.ClienteId  
    ,SUM(CAST(cm.Monto AS DECIMAL(30,4)) ) AS TotalDeuda  
   FROM ClienteMovimiento cm  
    INNER JOIN Cliente c on cm.ClienteId = c.ClienteId  
    AND cm.ConsultoraId = c.ConsultoraId  
   WHERE cm.ConsultoraId = @consultoraId  
    AND c.Activo = 1  
   GROUP BY cm.ClienteId  
   HAVING SUM(CAST(cm.Monto AS DECIMAL(30,4))) > 0  
   )  
 SELECT Count(ClienteId) AS CantidadDeudores  
  ,SUM(cd.TotalDeuda) AS TotalDeuda  
 FROM Cliente_Deuda cd;  
  
 -- Pedido  
 SELECT ISNULL(pw.MotivoCreditoID, 0) AS MotivoCreditoID  
  ,CAST(pw.IndicadorEnviado AS INT) AS IndicadorEnviado  
  ,pw.PedidoId  
  ,pw.FechaRegistro  
  ,pw.ImporteTotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,Count(DISTINCT pwd.ClienteId) AS CantidadclientesPedido  
  ,Count(pwd.CUV) AS CantidadproductosPedido
 FROM dbo.PedidoWeb pw  
 INNER JOIN dbo.PedidoWebDetalle pwd ON PW.PedidoID = pwd.PedidoID  
  AND pw.consultoraid = pwd.consultoraid  
  AND pw.CampaniaID = pwd.CampaniaID  
 LEFT JOIN Cliente c ON pwd.ClienteID = c.ClienteId
  AND pwd.Consultoraid = c.consultoraid  
 WHERE isnull(c.Activo,1) = 1   
  AND pw.CampaniaID = @codigoCampania  
  AND pw.ConsultoraID = @ConsultoraID  
 GROUP BY pw.PedidoID  
  ,pw.MotivoCreditoID  
  ,pw.IndicadorEnviado  
  ,pw.fecharegistro  
  ,pw.importetotal  
  ,pw.DescuentoProl  
  ,pw.MontoEscala  
  ,pw.MontoAhorroCatalogo  
  ,pw.MontoAhorroRevista  
  ,pw.IndicadorEnviado  
  ,pw.CampaniaID  
END  

GO

