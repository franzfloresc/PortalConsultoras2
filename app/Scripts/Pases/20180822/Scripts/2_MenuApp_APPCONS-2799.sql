USE BelcorpPeru
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpMexico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpColombia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpSalvador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpPuertoRico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpPanama
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpGuatemala
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpEcuador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpDominicana
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpCostaRica
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpChile
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

USE BelcorpBolivia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 4;
/* CLONAMOS EL MENU 3 CON VERSION 4 */
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
SELECT [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,4
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 3;

