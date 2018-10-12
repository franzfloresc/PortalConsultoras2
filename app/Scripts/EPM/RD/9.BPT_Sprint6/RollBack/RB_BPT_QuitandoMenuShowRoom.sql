USE BelcorpBolivia
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpChile
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpColombia
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpCostaRica
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpDominicana
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpEcuador
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpGuatemala
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpMexico
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpPanama
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpPeru
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpPuertoRico
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpSalvador
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go

USE BelcorpVenezuela
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	declare @PermisoID int = 0
	select @PermisoID = max(PermisoID) from Permiso

	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(@PermisoID+1,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,@PermisoID+1,1,1)
end

go

update Permiso set 
	UrlImagen='',
	UrlItem='',
	Codigo='ShowRoom'
where Codigo = 'ContenedorOfertas'

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigital')
begin
	declare @MenuMobileID int = 0
	select @MenuMobileID = max(MenuMobileID) from MenuMobile

	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(@MenuMobileID+1,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

update MenuMobile set
	Descripcion = 'VENTA EXCLUSIVA WEB',
	UrlItem = '',
	UrlImagen = '',
	Codigo = 'ShowRoom'
where Codigo = 'ContenedorOfertas'

go