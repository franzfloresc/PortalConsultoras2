USE BelcorpMexico
GO

DECLARE @PermisoID INT

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'ACCESO')
BEGIN	
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'ACCESO'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACI�N')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACI�N'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICI�N')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICI�N'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

IF EXISTS (SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACI�N')
BEGIN
	SELECT @PermisoID = MenuMobileID FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACI�N'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID
END

GO