USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'Mis certificados')
BEGIN
	DECLARE @PermisoID INT;
	
	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = 'Mis certificados';
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID;
	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID;
END;

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'Mis certificados')
BEGIN
	DECLARE @PermisoID INT;
	
	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = 'Mis certificados';
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID;
	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID;
END;

GO