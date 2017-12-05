USE BelcorpPeru
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpMexico
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpColombia
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpVenezuela
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpSalvador
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpPuertoRico
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpPanama
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpGuatemala
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpEcuador
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpDominicana
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpCostaRica
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpChile
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

USE BelcorpBolivia
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	NOT EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Catálogos'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS INT = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	
	SELECT @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = MAX(TABLALOGICADATOSID) + 1
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL

	IF(@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS IS NULL)
	BEGIN
		SET @ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS = @ID_TABLA_LOGICA_REVISTA_DIGITAL * 100 + 1
	END

	PRINT 'INSERT ''Catálogos'' INTO TABLALOGICADATOS'

	INSERT INTO TABLALOGICADATOS (
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	)
	VALUES (
	@ID_TABLA_LOGICA_DATOS_MENU_MOBILE_CATALOGOS
	,@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'Catálogos'
	,'Texto del menu ''Catálogos y Revistas'' cuando la consultora tiene GND'
	)
END

