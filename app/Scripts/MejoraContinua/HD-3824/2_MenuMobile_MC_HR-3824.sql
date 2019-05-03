USE [BelcorpBolivia]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/BO/cronograma-dias-de-venta-bolivia-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpChile]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CL/cronograma-dias-de-venta-chile-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpColombia]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CO/cronograma-dias-de-venta-colombia-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpCostaRica]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CO/cronograma-dias-de-venta-costarica-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpDominicana]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/DO/cronograma-dias-de-venta-dominicana-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpEcuador]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/EC/cronograma-dias-de-venta-ecuador-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpGuatemala]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);

	IF NOT EXISTS(SELECT OrdenItem FROM MenuMobile WHERE MenuPadreID = @IDPadre)
	BEGIN
		SET @OrdenItem = 0;
	END
	ELSE
	BEGIN
		SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);
	END

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/GT/cronograma-dias-de-venta-guatemala-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpMexico]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/MX/cronograma-dias-de-venta-mexico-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpPanama]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PA/cronograma-dias-de-venta-panama-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpPeru]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/cronograma-dias-de-venta-peru-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpPuertoRico]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PR/cronograma-dias-de-venta-puertorico-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO

USE [BelcorpSalvador]
GO
IF NOT EXISTS(SELECT MenuMobileID FROM MenuMobile WHERE Descripcion = 'FECHAS DE PROMOCIONES')
BEGIN
	DECLARE @IDPadre INT
	DECLARE @MenuMobileID INT
	DECLARE @OrdenItem INT

	SET @IDPadre = (SELECT MenuMobileID FROM MenuMobile WHERE DESCRIPCION = 'LEGAL' AND MenuPadreID = 0);
	SET @MenuMobileID = (SELECT MAX(MenuMobileID) FROM MenuMobile);
	SET @OrdenItem = (SELECT MAX(OrdenItem) FROM MenuMobile WHERE MenuPadreID = @IDPadre);

	INSERT INTO MenuMobile
	(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2, Codigo)
	VALUES ((@MenuMobileID + 1), 'FECHAS DE PROMOCIONES', @IDPadre, @OrdenItem + 1,
	'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/SV/cronograma-dias-de-venta-salvador-2019.pdf', '', 1, 'Footer', 'Completa', 1, NULL);
END
GO
