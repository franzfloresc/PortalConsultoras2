USE BelcorpBolivia
go

USE BelcorpChile_BPT
go

USE BelcorpColombia
go

USE BelcorpCostaRica
go

USE BelcorpDominicana
go

USE BelcorpEcuador
go

USE BelcorpGuatemala
go

USE BelcorpMexico
go

USE BelcorpPanama
go

USE BelcorpPeru_BPT
go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigital')
begin
	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(1058,'ÉSIKA PARA MÍ',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',1,
	0,0,1,'RevistaDigital')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,1058,1,1)
end

go

if not exists (select 1 from Permiso where Codigo = 'RevistaDigitalShowRoom')
begin
	insert into Permiso 
	(PermisoID,Descripcion,IdPadre,OrdenItem,UrlItem,PaginaNueva,Posicion,UrlImagen,EsSoloImagen,
	EsMenuEspecial,EsServicios,EsPrincipal,Codigo)
	values
	(1065,'PRODUCTOS PERSONALIZADOS',0,7,'RevistaDigital/Index',0,'Header','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/GIF_EPM_showroom.gif',1,
	0,0,1,'RevistaDigitalShowRoom')

	insert into RolPermiso (RolID,PermisoID,Activo,Mostrar)
	values (1,1065,1,1)
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
	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(1040,'ÉSIKA PARA MÍ',0,0,'Mobile/RevistaDigital','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/MenuEsikaParaMi.gif',
	0,'Menu','Mobile',1,'RevistaDigital')
end

go

if not exists (select 1 from MenuMobile where codigo = 'RevistaDigitalShowRoom')
begin
	insert into MenuMobile 
	(MenuMobileID,Descripcion,MenuPadreID,OrdenItem,UrlItem,UrlImagen,PaginaNueva,Posicion,Version,EsSB2,Codigo)
	values
	(1043,'PRODUCTOS PERSONALIZADOS',0,0,'RevistaDigital/Index','http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/GIF_EPM_showroom.gif',
	0,'Menu','Mobile',1,'RevistaDigitalShowRoom')
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

USE BelcorpSalvador
go

USE BelcorpVenezuela
go