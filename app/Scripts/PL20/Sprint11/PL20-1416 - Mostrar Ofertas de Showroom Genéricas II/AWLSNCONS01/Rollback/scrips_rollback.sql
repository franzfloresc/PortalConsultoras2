USE BelcorpBolivia
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpChile
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpColombia
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpCostaRica
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpDominicana
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpEcuador
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpGuatemala
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpMexico
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPanama
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPeru
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPuertoRico
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpSalvador
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpVenezuela
go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go