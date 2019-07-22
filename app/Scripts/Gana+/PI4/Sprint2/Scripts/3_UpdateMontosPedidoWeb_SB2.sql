USE BelcorpPeru
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpMexico
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpColombia
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpSalvador
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpPuertoRico
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpPanama
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpGuatemala
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpEcuador
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpDominicana
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpCostaRica
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpChile
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

USE BelcorpBolivia
GO

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
 @GananciaOtros money = null	
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
  GananciaRevista = @GananciaRevista,
  GananciaWeb = @GananciaWeb,
  GananciaOtros = @GananciaOtros
 where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;  
end  
GO

