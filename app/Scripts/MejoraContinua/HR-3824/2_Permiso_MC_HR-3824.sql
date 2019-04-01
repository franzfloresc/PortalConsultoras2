USE [BelcorpBolivia];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpChile];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpColombia];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpCostaRica];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpDominicana];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpEcuador];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpGuatemala];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpMexico];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpPanama];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpPeru];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpPuertoRico];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
USE [BelcorpSalvador];
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @RolID INT = 1
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)
END

GO
