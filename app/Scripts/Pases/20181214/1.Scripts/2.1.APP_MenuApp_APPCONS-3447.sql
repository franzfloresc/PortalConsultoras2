USE BelcorpPeru
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpMexico
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpColombia
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7


INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpSalvador
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7


INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpPuertoRico
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7


INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpPanama
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpGuatemala
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpEcuador
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpDominicana
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpCostaRica
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpChile
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO

USE BelcorpBolivia
GO

DELETE FROM dbo.MenuApp
WHERE VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu,
	Descripcion2,
	Descripcion3
)
SELECT 
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	7,
	Descripcion2,
	Descripcion3
FROM dbo.MenuApp
WHERE VersionMenu = 6

UPDATE dbo.MenuApp
SET Orden = 8
WHERE Codigo = 'MEN_LAT_CAM_EXITO'
AND VersionMenu = 7

UPDATE dbo.MenuApp
SET Orden = 9
WHERE Codigo = 'MEN_LAT_TUVOZ'
AND VersionMenu = 7

INSERT INTO dbo.MenuApp
(
	Codigo,
	Descripcion,
	Orden,
	CodigoMenuPadre,
	Posicion,
	Visible,
	VersionMenu
)
VALUES
(
	'MEN_LAT_MAQVIR',
	'MAQUILLADOR VIRTUAL',
	7,
	'MEN_LAT_GRUPO1',
	4,
	1,
	7
)
GO