
use [BelcorpPeru]

go

delete from TipoEstrategia where DescripcionEstrategia = 'Pack Nuevas' and isnull(CodigoPrograma, '')  = '' 

update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 3012

declare @maxPermiso int = 0, @codigoMenu varchar(100) = 'RevistaDigitalShowRoom'
select top 1 @maxPermiso = PermisoID + 1 from Permiso order by PermisoID desc

IF NOT EXISTS(SELECT * FROM Permiso WHERE Codigo = @codigoMenu)
begin
	insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	values(@maxPermiso, 'PRODUCTOS PERSONALIZADOS', 0, 7, 'OfertaPersonalizada/Index', 0, 'Header', 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/GIF_EPM_showroom.gif', 1, 0, 0, 1, @codigoMenu)

	insert into RolPermiso (RolID, PermisoID, Activo, Mostrar)
	values(1, @maxPermiso, 1, 1)
end

IF NOT EXISTS(SELECT * FROM MenuMobile WHERE Codigo = @codigoMenu)
begin
	select top 1 @maxPermiso = MenuMobileID + 1 from MenuMobile order by MenuMobileID desc
	insert into MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	values(@maxPermiso, 'PRODUCTOS PERSONALIZADOS', 0, 0, 'OfertaPersonalizada/Index', 'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/Menu/GIF_EPM_showroom.gif', 0, 'Menu', 'Mobile', 1, @codigoMenu)
end
go

go
use [BelcorpBolivia]

go 

update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 2004

go
use [BelcorpChile]

go 

update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 2004

go

use [BelcorpColombia]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 1005

go

use [BelcorpCostaRica]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 1008

go


use [BelcorpDominicana]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 2004

go

use [BelcorpEcuador]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 2

go

use [BelcorpGuatemala]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 6

go

use [BelcorpMexico]

--go 
--update TipoEstrategia
--set Codigo = '002'
--where TipoEstrategiaID = 2

go

use [BelcorpPanama]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 8

go


use [BelcorpPuertoRico]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 4

go

use [BelcorpSalvador]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 5

go

use [BelcorpVenezuela]

go 
update TipoEstrategia
set Codigo = '002'
where TipoEstrategiaID = 2

go
