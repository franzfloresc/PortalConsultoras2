
go
update Permiso
set Codigo = 'SociaEmpresaria'
where PermisoId = 1002

go
update Permiso
set Codigo = 'MiMegocio'
where PermisoId = 1003

go
update Permiso
set Codigo = 'MiAcademia'
where PermisoId = 1004

go
update Permiso
set Codigo = 'MiComunidad'
where PermisoId = 1005

go
update Permiso
set Codigo = 'MiAsesorBelleza'
, IdPadre = 1003
, OrdenItem = (select max(p.OrdenItem)  + 1 from Permiso p where p.IdPadre = 1003)
where PermisoId = 1006

go