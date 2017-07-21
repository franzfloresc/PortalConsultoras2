
use [BelcorpPeru]

go

update Permiso
set Codigo = 'Megocio'
where PermisoId = 1003

go
update Permiso
set Codigo = 'AsesorBelleza'
, IdPadre = 1003 -- 0
, OrdenItem = 13 -- 5
where PermisoId = 1006

go

declare @maxPermiso int = 0, @codigoMenu varchar(100) = 'RevistaDigitalShowRoom'
select top 1 @maxPermiso = PermisoID + 1 from Permiso order by PermisoID desc

IF NOT EXISTS(SELECT * FROM Permiso WHERE Codigo = @codigoMenu)
begin
	insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(@maxPermiso, 'PRODUCTOS PERSONALIZADOS', 0, 7, 'OfertaPersonalizada/Index', 0, 'Header', 'https://media.giphy.com/media/xUn3CpQrJATgAYDux2/giphy.gif', 1, 0, 0, 1, @codigoMenu)

	insert into RolPermiso (RolID, PermisoID, Activo, Mostrar)
	values(1, @maxPermiso, 1, 1)
end

IF NOT EXISTS(SELECT * FROM MenuMobile WHERE Codigo = @codigoMenu)
begin
	select top 1 @maxPermiso = MenuMobileID + 1 from MenuMobile order by MenuMobileID desc
	insert into MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	values(@maxPermiso, 'PRODUCTOS PERSONALIZADOS', 0, 0, 'OfertaPersonalizada/Index', 'https://media.giphy.com/media/xUn3CpQrJATgAYDux2/giphy.gif', 0, 'Menu', 'Mobile', 1, @codigoMenu)
end
go


