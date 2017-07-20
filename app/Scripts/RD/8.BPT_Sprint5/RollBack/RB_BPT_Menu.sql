
use [BelcorpPeru]

go

update Permiso
set Codigo = 'Megocio'
where PermisoId = 1003

go
update Permiso
set Codigo = 'AsesorBelleza'
, IdPadre = 0 
, OrdenItem = 5 
where PermisoId = 1006

go

