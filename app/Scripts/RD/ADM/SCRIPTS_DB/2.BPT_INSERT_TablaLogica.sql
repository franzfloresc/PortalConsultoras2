USE BelcorpPeru
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpMexico
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpColombia
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpVenezuela
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpSalvador
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpPuertoRico
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpPanama
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpGuatemala
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpEcuador
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpDominicana
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpCostaRica
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpChile
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

USE BelcorpBolivia
GO

--------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 102)
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion)
	VALUES (102, 'Detalle para estrategia.');
GO

--------------------------------------------------------------------------------------------------
-- INSERTAR VALORES EN LA TABLA LOGICA DATOS PARA EL DETALLE DE REVISTA DIGITAL (TODOS LOS PAISES)
--------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10101)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10201, 102, '01', 'Imagen Fondo Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10102)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10202, 102, '02', 'Imagen Previsual Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10103)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10203, 102, '03', 'Imagen Sello de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10104)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10204, 102, '04', 'URL Video Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10105)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10205, 102, '05', 'Imagen Fondo Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10206, 102, '06', 'Imagen Sello de ficha Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10207, 102, '07', 'URL Video Mobile');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10106)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10208, 102, '08', 'Imagen Fondo de ficha Desktop');
GO

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10107)
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion)
	VALUES (10209, 102, '09', 'Imagen Fondo de ficha Mobile');
GO

