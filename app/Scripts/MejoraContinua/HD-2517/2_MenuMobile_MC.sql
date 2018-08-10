USE BelcorpMexico
GO

DECLARE @IDPadre INT = 1018
DECLARE @RolID INT = 1
DECLARE @PermisoID INT
DECLARE @OrdenItem INT
DECLARE @Nombre VARCHAR(100) = ''

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'ACCESO')
BEGIN
	SET @Nombre = 'ACCESO'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Acceso.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACIÓN')
BEGIN
	SET @Nombre = 'CANCELACIÓN'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Cancelación.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICIÓN')
BEGIN
	SET @Nombre = 'OPOSICIÓN'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Oposición.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACIÓN')
BEGIN
	SET @Nombre = 'RECTIFICACIÓN'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Rectificación.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

GO