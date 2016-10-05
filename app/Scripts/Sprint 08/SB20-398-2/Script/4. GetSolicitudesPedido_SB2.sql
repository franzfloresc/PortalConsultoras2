USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   

/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedido_SB2]    
(
	@ConsultoraId bigint,
	@Campania int
)
as    
BEGIN    

declare @RegionID int, @ZonaID int
declare @FechaInicioFact datetime, @FechaFinFact datetime

select @RegionID = RegionID, @ZonaID = ZonaID from ods.Consultora where ConsultoraID = @ConsultoraId

select top 1 @FechaInicioFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo < @Campania and RegionID = @RegionID and ZonaID = @ZonaID
order by c.CampaniaID desc

select top 1 @FechaFinFact = FechaFinFacturacion 
from ods.Campania c inner join ods.Cronograma cc on c.CampaniaID = cc.CampaniaID 
where c.Codigo = @Campania and RegionID = @RegionID and ZonaID = @ZonaID

set @FechaInicioFact = dateadd(day,1,@FechaInicioFact)

select   
	SolicitudClienteID,  
	sc.MarcaID,  
	Campania,  
	NombreCompleto,  
	Telefono,  
	Direccion,  
	Email,  
	Mensaje, 
	Leido,  
	Estado,  
	NumIteracion,  
	CodigoUbigeo,  
	FechaSolicitud,  
	FechaModificacion,
	isnull(FlagConsultora,0) as FlagConsultora,
	FlagMedio, 
	(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
	(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
	m.Descripcion as Marca,
	--'05:30:27' as SaldoHoras,
	case isnull(FlagConsultora,0) 
		when 1 then '00:00:00' 
		--else '5:30:27'
		else dbo.CalcDiffTimeSolicitudPedido(FechaSolicitud)
	end SaldoHoras,
	isnull(PedidoWebID,0) as PedidoWebID
from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
where ConsultoraID = @ConsultoraId 
and ( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
and cast(sc.FechaSolicitud as date) between cast(@FechaInicioFact as date) and cast(@FechaFinFact as date)
--and ( 
--	( isnull(FlagConsultora,0) = 0 and  dateadd(hh,24,FechaSolicitud) <= getdate() )
--	or ( sc.FechaSolicitud between @FechaInicioFact and @FechaFinFact )
--)
--dateadd(hh,24,FechaSolicitud) <= getdate()		
--order by FechaSolicitud desc
ORDER BY 
ISNULL(FlagConsultora,0) DESC,
ISNULL(sc.MarcaID,0) ASC,
FechaSolicitud ASC,
PrecioTotal DESC

END   