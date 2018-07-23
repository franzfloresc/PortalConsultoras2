USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'Mis certificados')
BEGIN

    DECLARE @IDPadre INT = 1001;
    DECLARE @RolID INT = 1;
    DECLARE @PermisoID INT;
    DECLARE @OrdenItem INT;

    SELECT @PermisoID = MAX(MenuMobileID)
    FROM dbo.MenuMobile;

    SELECT @OrdenItem = MAX(OrdenItem)
    FROM dbo.MenuMobile
    WHERE MenuPadreID = @IDPadre;

    INSERT INTO dbo.MenuMobile
    (
        MenuMobileID,
        Descripcion,
        MenuPadreID,
        OrdenItem,
        UrlItem,
        UrlImagen,
        PaginaNueva,
        Posicion,
        Version,
        EsSB2,
        Codigo
    )
    VALUES
    (@PermisoID + 1, 'Mis certificados', @IDPadre, @OrdenItem + 1, 'Mobile/MisCertificados', '', 0, 'Menu', 'Mobile', 1, '');

END;

GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'Mis certificados')
BEGIN

    DECLARE @IDPadre INT = 1001;
    DECLARE @RolID INT = 1;
    DECLARE @PermisoID INT;
    DECLARE @OrdenItem INT;

    SELECT @PermisoID = MAX(MenuMobileID)
    FROM dbo.MenuMobile;

    SELECT @OrdenItem = MAX(OrdenItem)
    FROM dbo.MenuMobile
    WHERE MenuPadreID = @IDPadre;

    INSERT INTO dbo.MenuMobile
    (
        MenuMobileID,
        Descripcion,
        MenuPadreID,
        OrdenItem,
        UrlItem,
        UrlImagen,
        PaginaNueva,
        Posicion,
        Version,
        EsSB2,
        Codigo
    )
    VALUES
    (@PermisoID + 1, 'Mis certificados', @IDPadre, @OrdenItem + 1, 'Mobile/MisCertificados', '', 0, 'Menu', 'Mobile', 1, '');

END;

GO