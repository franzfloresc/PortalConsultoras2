USE Belcorpmexico
GO

DECLARE @IDPadre INT = 1041
DECLARE @RolID INT = 1
DECLARE @PermisoID INT
DECLARE @OrdenItem INT
DECLARE @Nombre VARCHAR(100) = ''

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'ACCESO')
BEGIN
	SET @Nombre = 'ACCESO'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Acceso.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'CANCELACI�N')
BEGIN
	SET @Nombre = 'CANCELACI�N'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Cancelaci�n.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'OPOSICI�N')
BEGIN
	SET @Nombre = 'OPOSICI�N'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Oposici�n.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'RECTIFICACI�N')
BEGIN
	SET @Nombre = 'RECTIFICACI�N'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Rectificaci�n.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END
