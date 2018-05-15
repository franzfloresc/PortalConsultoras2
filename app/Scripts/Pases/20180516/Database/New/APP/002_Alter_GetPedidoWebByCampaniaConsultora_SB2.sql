USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetPedidoWebByCampaniaConsultora_SB2', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
(  
 @CampaniaID int,  
 @ConsultoraID int  
)  
AS  
BEGIN  
  
SET NOCOUNT ON;  
  
SELECT   
 CampaniaID,  
 PedidoID,  
 ConsultoraID,  
 FechaRegistro,  
 FechaModificacion,  
 FechaReserva,  
 Clientes,  
 ImporteTotal,  
 ImporteCredito,  
 EstadoPedido,  
 ModificaPedidoReservado,  
 ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,  
 PaisID,  
 Bloqueado,  
 DescripcionBloqueo,  
 CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,  
 FechaProceso,  
 IPUsuario,  
 EstimadoGanancia,  
 CodigoUsuarioCreacion,  
 CodigoUsuarioModificacion,  
 DescuentoProl,  
 MontoEscala,  
 MontoAhorroCatalogo,  
 MontoAhorroRevista  ,
 ValidacionAbierta
FROM dbo.PedidoWeb WITH (NOLOCK)  
WHERE   
 CampaniaID = @CampaniaID   
 AND ConsultoraID = @ConsultoraID  
  
END  
  
GO

