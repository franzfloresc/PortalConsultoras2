
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


declare @maxPermiso int = 0, @codigoMenu varchar(100) = 'RevistaDigitalShowRoom'
select @maxPermiso = PermisoID from Permiso where Codigo = @codigoMenu

delete from RolPermiso where PermisoID = @maxPermiso
delete from Permiso where Codigo = @codigoMenu
delete from MenuMobile where Codigo = @codigoMenu

go

