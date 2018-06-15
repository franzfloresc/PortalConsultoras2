USE BelcorpPeru
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
END;

GO