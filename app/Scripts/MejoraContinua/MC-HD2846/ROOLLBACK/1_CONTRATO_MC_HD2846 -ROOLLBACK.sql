if exists(select 1 from Permiso where Descripcion = 'Reporte de Contrato')
begin

	declare @PermisoID int = 0
	select @PermisoID = PermisoID from Permiso where Descripcion = 'Reporte de Contrato'

	delete from RolPermiso where PermisoID = @PermisoID
	delete from Permiso where PermisoID = @PermisoID

end
GO