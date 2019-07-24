USE BelcorpColombia
GO
DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'CaminoBrillante')
Update RolPermiso set Mostrar = 0 where PermisoID = @PermisoID