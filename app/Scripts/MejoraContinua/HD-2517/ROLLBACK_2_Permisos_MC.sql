USE Belcorpmexico
GO

DECLARE @PermisoID INT;
DECLARE @Nombre VARCHAR(100) = ''

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'ACCESO')
BEGIN	
	SET @Nombre = 'ACCESO'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'CANCELACIÓN')
BEGIN	
	SET @Nombre = 'CANCELACIÓN'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'OPOSICIÓN')
BEGIN	
	SET @Nombre = 'OPOSICIÓN'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'RECTIFICACIÓN')
BEGIN	
	SET @Nombre = 'RECTIFICACIÓN'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END
GO