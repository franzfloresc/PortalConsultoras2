USE BelcorpColombia
GO

if not exists (select 1 from MenuApp where VersionMenu = 9)
begin
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
end
GO