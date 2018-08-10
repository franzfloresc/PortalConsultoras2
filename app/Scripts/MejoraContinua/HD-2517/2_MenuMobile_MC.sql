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

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'CANCELACI�N')
BEGIN
	SET @Nombre = 'CANCELACI�N'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Cancelaci�n.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'OPOSICI�N')
BEGIN
	SET @Nombre = 'OPOSICI�N'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Oposici�n.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

IF NOT EXISTS(SELECT 1 FROM dbo.MenuMobile WHERE Descripcion = 'RECTIFICACI�N')
BEGIN
	SET @Nombre = 'RECTIFICACI�N'

    SELECT @PermisoID = MAX(MenuMobileID) FROM dbo.MenuMobile

    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.MenuMobile WHERE MenuPadreID = @IDPadre

    INSERT INTO dbo.MenuMobile (MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, Version, EsSB2, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Rectificaci�n.pdf', '', 1, 'Footer', 'Completa', 1, '')
END

GO