/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 100 [TablaLogicaID]
--	,[Descripcion]
--FROM [BelcorpMexico_PL50].[dbo].[TablaLogica]


INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Descripcion
	)
VALUES (
	9855
	,98
	,'bar_in_act'
	,'true'
	)

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Descripcion
	)
VALUES (
	9856
	,98
	,'bar_in_url'
	,'http://somosbelcorp/showroom'
	)

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Descripcion
	)
VALUES (
	9857
	,98
	,'bar_in_img'
	,'http://via.placeholder.com/1600x150'
	)


	
SELECT TOP 200 *
FROM [dbo].[TablaLogicaDatos]
WHERE TablaLogicaId = 98