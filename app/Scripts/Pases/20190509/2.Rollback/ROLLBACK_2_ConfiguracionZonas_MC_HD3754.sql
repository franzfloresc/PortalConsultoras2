use [BelcorpMexico];
go

delete  RolPermiso where PermisoID=( Select PermisoID from Permiso WITH(NOLOCK)  
where Descripcion= 'Configuración de Zonas' and IdPadre=434 )
delete from Permiso WITH(NOLOCK) where Descripcion= 'Configuración de Zonas' and IdPadre=434 