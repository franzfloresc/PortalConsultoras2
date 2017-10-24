USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS 
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SET @TipoEstrategiaID = CASE @TipoEstrategia
		WHEN 1 THEN 10
		WHEN 2 THEN 1009
		WHEN 3 THEN 2009 
		WHEN 4 THEN 3009
		WHEN 5 THEN 3011 
		WHEN 6 THEN 3012 
		WHEN 7 THEN 3014 
		WHEN 8 THEN 3015 
		WHEN 9 THEN 3016 
		WHEN 10 THEN 3017 
		WHEN 11 THEN 3018
	END 

	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2231,2232,2233,2234,2235,2236,2237,2238,2239,2240,2241,2276,2310,2329,2588,2589,2590,2591,2592,2593,2036,2037,2039,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2008,2009,2103,2104,2105,2106,2107,2108,2110,2111,2112,21

13,2114,2115,2202,2203,2204,2208,2209,2210,2211,2212,2213,2305,2430,2431,2432,2434,2435,2438,2444,2445,2448,2488,2242,2243,2244,2245,2246,2247,2248,2249,2250,2251,2252,2253,2254,2255,2256,2257,2258,2259,2260,2133,2134,2135,2136,2139,2140,2141,2142,2143,21

44,2145,2146,2147,2148,2012,2013,2014,2177,2178,2179,2180,2181,2183,2184,2185,2186,2301,2311,2583,2584,2585,2261,2262,2263,2264,2425,2426,2427,2020,2022,2025,2031,2032,2034,2035,2433,2436,2437,2440,2443,2548,2568,2569,2570,2571,2572,2010,2011,2163,2164,21

65,2166,2167,2168,2169,2170,2171,2172,2173,2174,2175,2176,2015,2016,2017,2018,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198,2199,2200,2201,2423,2001,2002,2003,2004,2075,2076,2077,2078,2079,2081,2082,2083,2084,2085,2086,2088,2089,2223,2224,22

25,2226,2227,2228,2229,2306,2424,2446,2468,2508,2005,2006,2007,2090,2091,2092,2093,2094,2096,2098,2099,2100,2101,2302,2573,2574,2575,2576,2578,2149,2150,2151,2152,2153,2154,2155,2156,2157,2158,2159,2160,2161,2162,2304,2528,2579,2580,2581,2582',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
	FROM @EstrategiaTemporal
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'43,88,5,6,7,45,46,47,48,125,176,216,217,253,288,289,332,337,339,9,10,49,50,51,89,90,126,127,177,218,219,220,290,291,333,335,338,11,12,52,53,128,129,130,178,180,181,182,222,327,329,330,341,13,14,54,55,56,92,93,131,132,133,135,183,223,292,322,324,15,57,5
8,94,95,137,138,139,140,141,184,254,293,294,321,323,336,59,60,96,97,144,145,225,226,256,257,295,325,326,328,331,334,340,17,18,19,101,102,103,187,188,189,229,230,231,260,297,298,20,21,22,63,64,104,148,149,190,191,232,261,262,263,264,299,23,24,65,66,105,150
,151,152,192,193,194,195,233,265,266,300,25,26,106,107,153,154,155,156,157,158,159,196,197,267,268,269,301,27,67,68,69,70,108,109,110,111,160,161,162,198,199,200,234,270,271,28,29,30,71,72,73,112,163,164,201,202,235,236,272,31,32,33,74,75,76,113,165,203,2
37,238,239,274,275,34,77,78,114,115,116,166,167,204,205,206,276,277,278,302,35,79,80,81,117,118,119,168,169,207,208,279,303,304,36,37,38,82,120,121,170,209,240,280,281,305,306,307,39,83,122,123,210,241,242,243,282,308,309,310,311,40,41,84,124,171,211,212,
244,245,248,249,250,283,312,313,314,315,2,42,85,86,87,172,173,213,214,246,247,251,252,284,316,317,3,4,174,285,318,320,342,44,175',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO


CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'53,318,356,372,23,24,54,63,100,138,139,140,191,192,193,231,234,278,322,55,141,143,144,147,148,194,197,230,232,276,319,321,323,21,58,59,61,64,101,145,190,195,226,227,228,235,275,279,10,22,56,57,60,62,146,196,229,233,236,277,320,26,30,31,65,68,106,107,15
0,198,199,202,284,285,324,325,375,72,74,103,104,105,108,109,238,280,281,286,287,288,289,27,67,69,70,71,73,102,149,151,152,153,239,282,283,290,28,32,66,113,155,157,200,201,237,240,340,342,355,368,76,154,156,166,298,326,344,348,349,351,354,379,33,36,78,79,1
10,111,112,114,117,165,242,243,292,293,294,295,34,75,116,118,158,159,160,169,215,328,329,334,377,38,39,40,41,43,80,85,119,121,170,245,248,301,335,338,42,82,84,168,207,208,246,249,299,330,332,336,337,37,81,83,120,167,171,172,173,174,247,250,302,331,333,2,3
,5,9,45,46,86,122,125,213,256,259,300,303,6,48,89,92,124,175,179,211,214,251,252,257,258,260,7,44,47,91,176,180,181,209,210,253,254,255,304,307,308,4,8,11,87,88,90,123,177,178,212,217,305,306,374,49,93,126,127,128,130,183,184,216,218,262,263,264,268,309,1
6,132,221,311,373,17,19,51,96,97,133,135,187,188,189,219,265,272,274,312,13,15,50,94,129,136,222,266,267,270,271,314,316,317,20,99,357,358,359,360,361,362,363,364,365,366,367,369,370,378',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2147,2148,2149,2152,2153,2154,2773,2774,2776,2778,2779,2873,2167,2169,2170,2172,2174,2176,2177,2178,2179,2183,2822,2823,2825,2333,2335,2337,2343,2349,2508,2750,2772,2793,2794,2795,2798,2799,2801,2803,2208,2211,2686,2688,2690,2696,2813,2815,2816,2817,28
21,2824,2228,2229,2232,2243,2244,2674,2675,2676,2680,2681,2684,2250,2251,2253,2254,2484,2749,2751,2752,2755,2757,2758,2767,2768,2770,2269,2276,2707,2710,2711,2713,2714,2913,2914,2919,2923,2926,2928,2285,2289,2290,2291,2292,2301,2495,2500,2915,2916,2917,29
25,2354,2362,2364,2365,2372,2699,2701,2725,2729,2731,2732,2893,2894,2375,2378,2381,2384,2385,2386,2456,2459,2703,2736,2737,2946,2947,2948,2392,2394,2396,2397,2400,2401,2403,2404,2405,2406,2407,2408,2412,2413,2415,2416,2418,2419,2420,2920,2921,2924,2143,24
38,2436,2437,2570,2572,2573,2574,2575,2577,2581,2586,2587,2588,2936,2937,2943',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
		
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'20627,20637,20617,20618,20623,20628,20629,20633,20634,20640,20654,20655,20664,20669,20670,20613,20614,20615,20616,20624,20625,20631,20632,20639,20644,20652,20653,20661,20662,20610,20620,20630,20638,20642,20643,20646,20656,20657,20665,20672,20673,20609,
20619,20621,20635,20636,20645,20647,20648,20649,20650,20658,20659,20674,20612,20660,20668',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'43,44,82,42,50,52,56,57,60,63,64,70,72,79,84,88,90,91,97,99,100,46,54,59,73,83,85,86,87,89,92,93,94,95,98,75,80',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2493,2494,2535,2536,2541,2542,2543,2544,2545,2548,2551,2554,2555,2556,2557,2558,2559,2560,2561',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'20616,20654,20590,20593,20594,20609,20610,20615,20625,20641,20650,20651,20652,20653,20659,20598,20599,20600,20601,20602,20619,20622,20633,20635,20638,20647,20648,20656,20603,20604,20612,20623,20624,20630,20631,20645,20657,20666,20667,20670,20596,20611,
20617,20626,20627,20628,20642,20643,20644,20649,20663,20664,20668,20597,20618,20591,20606,20607,20608,20620,20621,20634,20636,20639,20640,20660,20661,20662,20655',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2094,2536,2357,2376,2390,2416,2443,2498,2501,2508,2515,2520,2521,2522,2525,2526,2528,2529,2531,2362,2363,2364,2378,2405,2446,2447,2458,2476,2523,2527,2532,2533,2534,2537,2381,2392,2417,2427,2428,2448,2460,2477,2483,2493,2496,2512,2382,2394,2407,24
18,2430,2432,2491,2495,2497,2500,2503,2504,2513,2517,2519,2370,2383,2396,2397,2408,2409,2419,2420,2433,2434,2452,2475,2481,2524,2530,2535,2371,2372,2384,2385,2398,2410,2411,2421,2422,2423,2424,2435,2453,2462,2472,2478,2373,2374,2375,2386,2387,2412,2425,24
36,2438,2439,2464,2465,2466,2482,2489,2388,2389,2399,2413,2414,2441,2442,2454,2455,2456,2467,2468,2469,2470,2471,2479',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'14,16,3,4,7,29,30,43,57,58,63,64,77,78,80,82,83,84,87,5,12,20,21,22,25,36,45,46,48,49,50,51,54,71,72,85,86,2,9,10,15,17,18,26,31,32,33,39,42,55,61,68,69,6,13,23,24,27,37,47,52,53,56,62,66,74,75,76,79,81,88,59,60',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	
	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @TipoEstrategiaID = CASE @TipoEstrategia
		WHEN 1 THEN 1
		WHEN 2 THEN 2
		WHEN 3 THEN 1002 
		WHEN 4 THEN 2002
		WHEN 5 THEN 2003 
		WHEN 7 THEN 3014 
		WHEN 8 THEN 3015 
		WHEN 9 THEN 3016 
		WHEN 10 THEN 3018 
		WHEN 11 THEN 3019
	END 
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'12144,12176,12122,12142,12156,12157,12158,12167,12168,12169,12173,12174,12175,12189,12190,12206,12108,12109,12110,12119,12120,12121,12134,12141,12143,12155,12170,12171,12172,12191,12105,12106,12116,12124,12126,12138,12146,12163,12164,12179,12180,12182,
12183,12199,12114,12115,12117,12125,12136,12137,12145,12147,12162,12181,12196,12197,12198,12210,12107,12118,12127,12133,12148,12149,12154,12165,12184,12185,12187,12200,12205,12128,12130,12131,12132,12150,12151,12152,12153,12166,12186,12202,12203,12204,121
11,12112,12113,12129,12139,12140,12159,12160,12178,12192,12193,12194,12195,12201,12209,12177,12135,12161',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
GO

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]
GO

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad
	FROM @EstrategiaTemporal
END
GO

CREATE  PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END
	
	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,
47,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		FROM @EstrategiaTemporal
END
GO

