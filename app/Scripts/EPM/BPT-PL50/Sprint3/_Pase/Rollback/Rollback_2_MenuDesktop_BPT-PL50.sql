

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM Permiso
		WHERE Codigo = 'UpSelling'
		)
BEGIN
	DECLARE @RolId INT = 4
	DECLARE @PermisoId INT

	SELECT @PermisoId = PermisoID FROM Permiso WHERE Codigo = 'UpSelling'

	DELETE FROM RolPermiso WHERE PermisoID = @PermisoId AND RolId = @RolId

	DELETE FROM Permiso WHERE PermisoID = @PermisoId

END
GO
