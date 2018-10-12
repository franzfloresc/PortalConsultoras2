USE BelcorpCostaRica
GO 
if exists(select 1 from Permiso where Descripcion = 'Zona de Estrategias MSSQL')
begin

	declare @PermisoID int = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Zona de Estrategias MSSQL'

	delete from RolPermiso where PermisoID = @PermisoID
	delete from Permiso where PermisoID = @PermisoID

end

go