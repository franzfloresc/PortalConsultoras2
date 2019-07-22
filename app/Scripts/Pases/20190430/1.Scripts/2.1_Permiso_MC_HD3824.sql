USE [BelcorpBolivia]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/BO/cronograma-dias-de-venta-bolivia-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpChile]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CL/cronograma-dias-de-venta-chile-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpColombia]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CO/cronograma-dias-de-venta-colombia-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpCostaRica]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CR/cronograma-dias-de-venta-costarica-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpDominicana]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/DO/cronograma-dias-de-venta-dominicana-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpEcuador]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/EC/cronograma-dias-de-venta-ecuador-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpGuatemala]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/GT/cronograma-dias-de-venta-guatemala-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpMexico]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/MX/cronograma-dias-de-venta-mexico-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpPanama]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PA/cronograma-dias-de-venta-panama-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpPeru]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpPuertoRico]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PR/cronograma-dias-de-venta-puertorico-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
USE [BelcorpSalvador]
GO
IF NOT EXISTS(SELECT 1 FROM Permiso WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT 
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	SET @IDPADRE = (SELECT PERMISOID FROM PERMISO WHERE DESCRIPCION = 'LEGAL' AND IDPADRE = 0)
	SELECT @PermisoID=MAX(PermisoID) FROM Permiso
	SELECT @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo)
	VALUES(@PermisoID+1, 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/SV/cronograma-dias-de-venta-salvador-2019.pdf',1,'Footer',NULL,0,0,0,1,NULL)
END

GO
