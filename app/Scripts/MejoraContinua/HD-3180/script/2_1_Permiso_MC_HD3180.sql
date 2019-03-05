USE BelcorpPeru
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end
go

USE BelcorpMexico
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpColombia
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpSalvador
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpPuertoRico
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpPanama
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpGuatemala
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpEcuador
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpDominicana
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpCostaRica
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpChile
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go

USE BelcorpBolivia
GO

declare @IdPadre int = 1091

if not exists(select 1 from Permiso where PermisoID = 1091)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1091,'MI PERFIL',0,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

if not exists(select 1 from Permiso where PermisoID = 1092)
begin
	insert into Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(1092,'MIS DATOS',@IdPadre,1,'',0,'Body','',0,0,0,1,'MiPerfil')
end

go
