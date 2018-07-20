USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'Mis certificados')
BEGIN

    DECLARE @IDPadre INT = 1003;
    DECLARE @RolID INT = 1;
    DECLARE @PermisoID INT;
    DECLARE @OrdenItem INT;

    SELECT @PermisoID = MAX(PermisoID)
    FROM dbo.Permiso;
	
    SELECT @OrdenItem = MAX(OrdenItem)
    FROM dbo.Permiso
    WHERE IdPadre = @IDPadre;

    INSERT INTO dbo.Permiso
    (
        PermisoID,
        Descripcion,
        IdPadre,
        OrdenItem,
        UrlItem,
        PaginaNueva,
        Posicion,
        UrlImagen,
        EsSoloImagen,
        EsMenuEspecial,
        EsServicios,
        EsPrincipal,
        Codigo
    )
    VALUES (@PermisoID + 1, 'Mis certificados', @IDPadre, 7, 'MisCertificados/Index', 0, 'Header', '', 0, 0, 0, 1, 'MisCertificados');
	 
    INSERT INTO dbo.RolPermiso(RolID, PermisoID, Activo, Mostrar)
    VALUES(@RolID, @PermisoID + 1, 1, 1);

END;
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Permiso WHERE Descripcion = 'Mis certificados')
BEGIN

    DECLARE @IDPadre INT = 1003;
    DECLARE @RolID INT = 1;
    DECLARE @PermisoID INT;
    DECLARE @OrdenItem INT;

    SELECT @PermisoID = MAX(PermisoID)
    FROM dbo.Permiso;
	
    SELECT @OrdenItem = MAX(OrdenItem)
    FROM dbo.Permiso
    WHERE IdPadre = @IDPadre;

    INSERT INTO dbo.Permiso
    (
        PermisoID,
        Descripcion,
        IdPadre,
        OrdenItem,
        UrlItem,
        PaginaNueva,
        Posicion,
        UrlImagen,
        EsSoloImagen,
        EsMenuEspecial,
        EsServicios,
        EsPrincipal,
        Codigo
    )
    VALUES (@PermisoID + 1, 'Mis certificados', @IDPadre, 7, 'MisCertificados/Index', 0, 'Header', '', 0, 0, 0, 1, 'MisCertificados');
	 
    INSERT INTO dbo.RolPermiso(RolID, PermisoID, Activo, Mostrar)
    VALUES(@RolID, @PermisoID + 1, 1, 1);

END;
GO