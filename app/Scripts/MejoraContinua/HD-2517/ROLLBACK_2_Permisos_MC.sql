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

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'CANCELACI�N')
BEGIN	
	SET @Nombre = 'CANCELACI�N'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'OPOSICI�N')
BEGIN	
	SET @Nombre = 'OPOSICI�N'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'RECTIFICACI�N')
BEGIN	
	SET @Nombre = 'RECTIFICACI�N'

	SELECT @PermisoID = PermisoID FROM dbo.Permiso WHERE Descripcion = @Nombre
	
	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID	
	DELETE FROM dbo.Permiso WHERE PermisoID = @PermisoID
END
GO