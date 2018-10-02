USE BelcorpPeru
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpMexico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpColombia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpSalvador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpPuertoRico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpPanama
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpGuatemala
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpEcuador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpDominicana
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpCostaRica
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpChile
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

USE BelcorpBolivia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 5;
/* CLONAMOS EL MENU 4 CON VERSION 5 */
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
      ,5
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 4;

