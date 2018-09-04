USE BelcorpMexico
GO

DECLARE @PermisoID INT

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'ACCESO')
BEGIN	
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'ACCESO'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACIÓN')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACIÓN'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICIÓN')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICIÓN'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACIÓN')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACIÓN'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

GO