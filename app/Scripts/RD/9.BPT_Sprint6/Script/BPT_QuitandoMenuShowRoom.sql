USE BelcorpBolivia
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpChile
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpColombia
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpCostaRica
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpDominicana
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpEcuador
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpGuatemala
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpMexico
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpPanama
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpPeru
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpPuertoRico
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpSalvador
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go

USE BelcorpVenezuela
go

--Eliminando Menus de mas
delete from RolPermiso where PermisoID in (select PermisoID from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom'))
delete from Permiso where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

--Actualizando Menu Contenedor de Ofertas
update Permiso set 
	Descripcion = 'OFERTAS',
	UrlImagen='',
	UrlItem='Ofertas/Index',
	Codigo='ContenedorOfertas'
where Codigo = 'ShowRoom'

go

delete from MenuMobile where Codigo in ('RevistaDigital','RevistaDigitalShowRoom')

go

update MenuMobile set
	Descripcion = 'OFERTAS',
	UrlItem = 'Mobile/Ofertas',
	UrlImagen = '',
	Codigo = 'ContenedorOfertas'
where Codigo = 'ShowRoom'

go