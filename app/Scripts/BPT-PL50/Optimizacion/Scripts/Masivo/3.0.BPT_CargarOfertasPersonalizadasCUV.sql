USE ODS_PE_BPT
GO

--USE BelcorpPeru_BPT
--GO

--USE BelcorpPeru
--GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1 
			FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CargarOfertasPersonalizadasCUV]') AND type in (N'P', N'PC')) 
BEGIN
	PRINT 'ELIMINANDO PROCEDURE  [dbo].CargarOfertasPersonalizadasCUV'
	DROP PROCEDURE [dbo].CargarOfertasPersonalizadasCUV
END
GO

PRINT 'CREANDO PROCEDURE  [dbo].CargarOfertasPersonalizadasCUV'
GO

CREATE PROCEDURE CargarOfertasPersonalizadasCUV
	@TipoPersonalizacionAnioCampanaVenta VARCHAR(MAX)
AS
BEGIN
	DECLARE @Filtro TABLE
	(
		TipoPersonalizacion VARCHAR(3)
		,AnioCampanaVenta	int
	)
	INSERT INTO @Filtro
	SELECT 
		TipoPersonalizacion = SUBSTRING(item,1,3)
		,AnioCampanaVenta = CONVERT(int, SUBSTRING(item,4,6))
	FROM (
		SELECT item
		FROM [dbo].[fnSplit](@TipoPersonalizacionAnioCampanaVenta, '-') 
	) TMP
	WHERE LEN(item) = 9

	DELETE OPC
	FROM OfertasPersonalizadasCUV OPC
		JOIN @Filtro F ON OPC.TipoPersonalizacion = F.TipoPersonalizacion
		AND OPC.AnioCampanaVenta = F.AnioCampanaVenta

	INSERT INTO OfertasPersonalizadasCUV
	SELECT 
	convert(int, OP.AnioCampanaVenta)
	,convert(varchar(10), OP.TipoPersonalizacion)
	,convert(varchar(6), OP.CUV)			
	,FlagUltMinuto = MAX(OP.FlagUltMinuto)	
	,LimUnidades = MAX(OP.LimUnidades)	
	FROM OfertasPersonalizadas OP
		JOIN @Filtro F ON OP.TipoPersonalizacion = F.TipoPersonalizacion
		AND OP.AnioCampanaVenta = F.AnioCampanaVenta
	GROUP BY
	OP.AnioCampanaVenta	
	,OP.TipoPersonalizacion
	,OP.CUV				
END
GO

