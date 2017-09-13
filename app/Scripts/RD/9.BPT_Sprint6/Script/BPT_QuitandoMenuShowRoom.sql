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

USE BelcorpSalvador
go

USE BelcorpVenezuela
go