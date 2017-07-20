
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

