USE BelcorpPeru
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,1,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','10');
GO

USE BelcorpMexico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpColombia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpSalvador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpPuertoRico
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpPanama
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpGuatemala
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpEcuador
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpDominicana
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpCostaRica
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpChile
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

USE BelcorpBolivia
GO

/* ELIMINAMOS EL MENU EXISTENTE */
DELETE MenuApp WHERE [VersionMenu] = 6;
GO
/* CLONAMOS EL MENU 5 CON VERSION 6 */
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
      ,6
      ,[Descripcion2]
      ,[Descripcion3]
FROM MenuApp
WHERE [VersionMenu] = 5;
GO

/* ELIMINAR MENU SI EXISTIERA */
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_CHAT_BOT';
DELETE MenuApp WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_TOP_CHAT_BOT';

/* CREAR NUEVO ITEM DE MENU */
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_LAT_CHAT_BOT','CHAT',0,'MEN_LAT_GRUPO2',4,0,6);
INSERT INTO MenuApp (Codigo, Descripcion, Orden, CodigoMenuPadre, Posicion, Visible, VersionMenu)
VALUES ('MEN_TOP_CHAT_BOT','CHAT',9,'',1,0,6);

/* CAMBIAR EL TITULO */
UPDATE MenuApp
SET Descripcion = '¿Necesitas ayuda?'
WHERE [VersionMenu] = 6 AND [Codigo] = 'MEN_LAT_GRUPO2'; 


/* ELIMINAMOS CHATBOT CONSULTORAS CONFIGURACION */
DELETE TablaLogicaDatos WHERE [TablaLogicaDatosID] = 14901;
DELETE TablaLogica WHERE [TablaLogicaID] = 149;

/* CHATBOT CONSULTORAS CONFIGURACION */
INSERT INTO TablaLogica ([TablaLogicaID] ,[Descripcion])
VALUES (149, 'CHATBOT Consultoras');
INSERT INTO TablaLogicaDatos ([TablaLogicaDatosID],[TablaLogicaID], [Codigo], [Descripcion], [Valor])
VALUES (14901,149,'FLAG_CHATBOT_APP','0: No Aplica, 1: Siempre, 1X: 100% digital, X1: Tradicional','0');
GO

