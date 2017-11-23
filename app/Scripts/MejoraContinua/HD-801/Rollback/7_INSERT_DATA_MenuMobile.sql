
USE BelcorpColombia
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.MenuMobile
    WHERE Descripcion = 'Mis certificados'
)
BEGIN
	DECLARE @PermisoID INT;
	
	SELECT @PermisoID = MenuMobileID
    FROM dbo.MenuMobile
    WHERE Descripcion = 'Mis certificados'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID;

	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID;
END;

GO

USE BelcorpEcuador
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.MenuMobile
    WHERE Descripcion = 'Mis certificados'
)
BEGIN
	DECLARE @PermisoID INT;
	
	SELECT @PermisoID = MenuMobileID
    FROM dbo.MenuMobile
    WHERE Descripcion = 'Mis certificados'
	
	DELETE FROM dbo.MenuMobile where MenuMobileID = @PermisoID;

	DELETE FROM dbo.RolPermiso WHERE PermisoID = @PermisoID;
END;

GO