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

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'CANCELACIÓN')
BEGIN
	SET @Nombre = 'CANCELACIÓN'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Cancelación.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'OPOSICIÓN')
BEGIN
	SET @Nombre = 'OPOSICIÓN'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Oposición.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'RECTIFICACIÓN')
BEGIN
	SET @Nombre = 'RECTIFICACIÓN'

    SELECT @PermisoID = MAX(PermisoID) FROM dbo.Permiso
	
    SELECT @OrdenItem = MAX(OrdenItem) FROM dbo.Permiso WHERE IdPadre = @IDPadre

    INSERT INTO dbo.Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
    VALUES (@PermisoID + 1, @Nombre, @IDPadre, @OrdenItem + 1, 'https://s3.amazonaws.com/consultorasQAS/Unete/Solicitud_de_Rectificación.pdf', 1, 'Footer', '', 0, 0, 0, 1  , @Nombre)
	 
    INSERT INTO dbo.RolPermiso (RolID, PermisoID, Activo, Mostrar)
    VALUES (@RolID, @PermisoID + 1, 1, 1)
END
