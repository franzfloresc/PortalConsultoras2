USE BelcorpPeru
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpMexico
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpColombia
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpSalvador
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpPuertoRico
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpPanama
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpGuatemala
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpEcuador
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpDominicana
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpCostaRica
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpChile
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

USE BelcorpBolivia
GO

/* UPDATE REGISTROS */
UPDATE MenuApp 
SET 
	[Descripcion] = 'OFERTAS DIGITALES',
	[Descripcion2] = 'CLUB GANA +',
	[Descripcion3] = 'OFERTAS DIGITALES'
WHERE [Codigo] IN ('MEN_TOP_OFERTAS', 'MEN_LAT_OFERTAS') 
	AND [VersionMenu] = 4;
/* OCULTAR MENU TOP PEDIDO  */
UPDATE MenuApp
	SET [Visible] = 0
WHERE [Codigo] = 'MEN_TOP_PEDIDO' 
	AND [VersionMenu] = 4;
/* INSERT NUEVO MENU TOP PEDIDO NATIVO  */
INSERT INTO MenuApp
 ([Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3])
SELECT 'MEN_TOP_PEDIDOSNAT'
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,1
      ,[VersionMenu]
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [Codigo] = 'MEN_TOP_PEDIDO'  AND [VersionMenu] = 4;

