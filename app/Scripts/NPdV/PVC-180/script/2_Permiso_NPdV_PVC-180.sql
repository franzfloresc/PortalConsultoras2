USE BelcorpColombia
GO
DECLARE @PermisoID int = (select PermisoID from Permiso where Codigo = 'CaminoBrillante')
Update RolPermiso set Mostrar = 1 where PermisoID = @PermisoID
