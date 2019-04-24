USE BelcorpPeru
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpMexico
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpColombia
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpSalvador
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpPuertoRico
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpPanama
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpGuatemala
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpEcuador
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpDominicana
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpCostaRica
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpChile
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

USE BelcorpBolivia
GO

INSERT INTO [dbo].[MenuApp](
	   [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,VersionMenu
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva])
SELECT 
      [Codigo]
      ,[Descripcion]
      ,[Orden]
      ,[CodigoMenuPadre]
      ,[Posicion]
      ,[Visible]
      ,9
      ,[Descripcion2]
      ,[Descripcion3]
      ,[VigenciaNueva]
FROM [dbo].[MenuApp]
WHERE VersionMenu = 8 ;

UPDATE [dbo].[MenuApp]
SET Orden = Orden + 1
WHERE VersionMenu = 9 AND Orden > 4
AND CodigoMenuPadre = 'MEN_LAT_NEGOCIO';

INSERT INTO [dbo].[MenuApp] ([Codigo],[Descripcion],[Orden],[CodigoMenuPadre],[Posicion],[Visible],[VersionMenu],[Descripcion2],[Descripcion3],[VigenciaNueva])
VALUES ('MEN_LAT_CAMINOBRILLANTE','CAMINO BRILLANTE',5,'MEN_LAT_NEGOCIO',4,0,9,NULL,NULL,NULL);
GO

