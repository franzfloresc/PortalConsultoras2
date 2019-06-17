Alter procedure UpdateMontosPedidoWeb_SB2  
 @CampaniaID int,  
 @ConsultoraID int,  
 @MontoAhorroCatalogo money,  
 @MontoAhorroRevista money,  
 @MontoDescuento money,  
 @MontoEscala money,  
 @VersionProl tinyint = 0,  
 @PedidoSapId bigint = 0,
 @GananciaRevista money = null,
 @GananciaWeb money = null,
 @GananciaOtros money = null,
as  
begin  
 update PedidoWeb   
 set  
  MontoAhorroCatalogo = @MontoAhorroCatalogo,  
  MontoAhorroRevista = @MontoAhorroRevista,  
  DescuentoProl = @MontoDescuento,  
  MontoEscala = @MontoEscala,  
  VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl),  
  PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
  GananciaRevista = GananciaRevista,
  GananciaWeb = GananciaWeb,
  GananciaOtros = GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  