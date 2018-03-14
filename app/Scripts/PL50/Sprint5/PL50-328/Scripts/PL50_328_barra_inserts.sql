/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 100 [TablaLogicaID]
--	,[Descripcion]
--FROM [BelcorpMexico_PL50].[dbo].[TablaLogica]
IF COL_LENGTH('dbo.TablaLogicaDatos', 'Valor') IS NULL
BEGIN
	ALTER TABLE TablaLogicaDatos ADD Valor VARCHAR(500);
END

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Valor
	,Descripcion
	)
VALUES (
	9855
	,98
	,'bar_in_act'
	,'true'
	,'barra inferrior showroom activo'
	)

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Valor
	,Descripcion
	)
VALUES (
	9856
	,98
	,'bar_in_url'
	,'http://somosbelcorp/showroom'
	,'Url redireccion banner'
	)

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Valor
	,Descripcion
	)
VALUES (
	9857
	,98
	,'bar_in_img'
	,'http://via.placeholder.com/1600x150'
	,'banner imagen fondo'
	)

INSERT INTO [TablaLogicaDatos] (
	TablaLogicaDatosID
	,TablaLogicaId
	,Codigo
	,Valor
	,Descripcion
	)
VALUES (
	9858
	,98
	,'bar_in_no'
	,'/ofertas'
	,'url parciales donde NO mostrar banner'
	)

SELECT TOP 200 *
FROM [dbo].[TablaLogicaDatos]
WHERE TablaLogicaId = 98

--DELETE [TablaLogicaDatos]
--WHERE TablaLogicaDatosId IN (
--		9855
--		,9856
--		,9857
--		)
