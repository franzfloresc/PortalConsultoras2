USE BelcorpColombia
GO
DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'CaminoBrillante')
select @PermisoID 
Update RolPermiso set Mostrar = 0 where PermisoID = @PermisoID