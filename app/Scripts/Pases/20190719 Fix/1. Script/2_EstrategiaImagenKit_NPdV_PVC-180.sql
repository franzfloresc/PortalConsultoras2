USE BelcorpColombia
GO
DELETE FROM EstrategiaImagenKit WHERE CampaniaID = 201912;

--CORAL
INSERT INTO [dbo].[EstrategiaImagenKit] ([CampaniaID] ,[CUV] ,[NombreImagen] ,[Fecha])
	VALUES (201912,'43832','http://somosbelcorpprd.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/KITS/CO/43832.jpg',GETDATE());
--ÁMBAR
INSERT INTO [dbo].[EstrategiaImagenKit] ([CampaniaID] ,[CUV] ,[NombreImagen] ,[Fecha])
	VALUES (201912,'43837','http://somosbelcorpprd.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/KITS/CO/43837.jpg',GETDATE());
--PERLA
INSERT INTO [dbo].[EstrategiaImagenKit] ([CampaniaID] ,[CUV] ,[NombreImagen] ,[Fecha])
	VALUES (201912,'43871','http://somosbelcorpprd.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/KITS/CO/43871.jpg',GETDATE());
--TOPACIO
INSERT INTO [dbo].[EstrategiaImagenKit] ([CampaniaID] ,[CUV] ,[NombreImagen] ,[Fecha])
	VALUES (201911,'43870','http://somosbelcorpprd.s3.amazonaws.com/Iconos/CAMINOBRILLANTE/KITS/CO/43870.jpg',GETDATE());