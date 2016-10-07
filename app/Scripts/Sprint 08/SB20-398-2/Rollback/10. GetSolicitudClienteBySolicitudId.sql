

USE BelcorpPeru
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpColombia
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpChile
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpEcuador
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpMexico
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpCostaRica
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/


USE BelcorpBolivia
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpDominicana
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpGuatemala
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpPanama
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpPuertoRico
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpSalvador
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end

/*end*/

USE BelcorpVenezuela
GO

ALTER procedure [dbo].[GetSolicitudClienteBySolicitudId](
@SolicitudId  bigint
)
as
begin
select Campania,ConsultoraID,FechaSolicitud,FechaModificacion,NombreCompleto,Leido,Email,Estado,Telefono,Mensaje,S.MarcaID,M.Nombre as MarcaNombre,NumIteracion,MensajeaCliente,CodigoUbigeo
from SolicitudCliente S inner join ods.Marca M on ( S.MarcaID = M.MarcaID)
where SolicitudClienteID = @SolicitudId
end
