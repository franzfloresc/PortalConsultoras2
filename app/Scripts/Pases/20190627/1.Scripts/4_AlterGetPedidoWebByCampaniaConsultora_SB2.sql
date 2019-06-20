USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2  
 @CampaniaID int,    
 @ConsultoraID int   
AS    
BEGIN    
    
SET NOCOUNT ON;    
    
SELECT     
  CampaniaID,PedidoID,
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
  MontoAhorroRevista,
  ValidacionAbierta,
  RecogerDNI,
  RecogerNombre,
  GananciaRevista,
  GananciaWeb,
  GananciaOtros
FROM dbo.PedidoWeb WITH (NOLOCK)    
WHERE CampaniaID = @CampaniaID     
   AND ConsultoraID = @ConsultoraID  
END 
GO