use BelcorpMexico_MC

delete  RolPermiso where PermisoID=( Select PermisoID from Permiso WITH(NOLOCK)  
where Descripcion= 'Configuraci�n de Zonas' and IdPadre=434 )
delete from Permiso WITH(NOLOCK) where Descripcion= 'Configuraci�n de Zonas' and IdPadre=434 