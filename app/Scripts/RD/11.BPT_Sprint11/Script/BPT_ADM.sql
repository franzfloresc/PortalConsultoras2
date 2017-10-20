USE BelcorpPeru_BPT

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

--IF EXISTS (SELECT * FROM sys.columns 
--WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
--BEGIN
--	ALTER TABLE Estrategia DROP CONSTRAINT CONS_Estrategia_PrecioPublico
--	ALTER TABLE Estrategia DROP COLUMN PrecioPublico
--END
--GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO

--IF EXISTS (SELECT * FROM sys.columns 
--WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
--BEGIN
--	ALTER TABLE EstrategiaTemporal DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
--	ALTER TABLE EstrategiaTemporal DROP COLUMN PrecioPublico
--END
--GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO

--IF EXISTS (SELECT * FROM sys.columns 
--WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
--BEGIN
--	ALTER TABLE Estrategia DROP CONSTRAINT CONS_Estrategia_Ganancia
--	ALTER TABLE Estrategia DROP COLUMN Ganancia
--END
--GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

--IF EXISTS (SELECT * FROM sys.columns 
--WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
--BEGIN
--	ALTER TABLE EstrategiaTemporal DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
--	ALTER TABLE EstrategiaTemporal DROP COLUMN Ganancia
--END
--GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
	@CampaniaID int,
	@TipoConfigurado int,
	@EstrategiaCodigo varchar(5) = '001'
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigoOds VARCHAR(5)
	SET @EstrategiaCodigoOds = CASE @EstrategiaCodigo 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		ELSE 'OPT'
	END;

	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigoOds
		GROUP BY CUV;
	
	IF @TipoConfigurado = 0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion,  p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto,
			p.IndicadorPreUni
		FROM @tablaCuvsOPT t
			INNER JOIN ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			LEFT JOIN MatrizComercial mc on
				p.CodigoProducto = mc.CodigoSAP
			LEFT JOIN MatrizComercialImagen mci on 
				mci.IdMatrizComercial = mc.IdMatrizComercial AND 
				mci.NemoTecnico IS NOT NULL
		WHERE 
			p.AnoCampania = @CampaniaID
			
		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0,'',0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto,
			p.IndicadorPreUni
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE e.CampaniaID = @CampaniaID
	END

	ELSE
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto,
			p.IndicadorPreUni
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null
	END
	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO

DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO

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
	[TieneVariedad] [int] NULL,
	[PrecioPublico] [decimal](18, 2) NULL,
	[Ganancia] [decimal](18, 2) NULL
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
		TieneVariedad,
		PrecioPublico,
		Ganancia)
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
		TieneVariedad,
		PrecioPublico,
		Ganancia
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
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia)
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
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia
	FROM @EstrategiaTemporal
END
GO


ALTER PROCEDURE [dbo].[ConsultarOfertaByCUV]

	@CampaniaID		  INT,
	@CUV2			  VARCHAR(20),
	@TipoEstrategiaID INT,
	@CUV1			  VARCHAR(20),
	@flag			  INT -- SI @flag ES { 0: CUV2, 1: CUV1, 2: Talla/Color, 3: Descripción vacía }

AS
BEGIN
--ConsultarOfertaByCUV 201416, '00024', 46, '', 3

	SET NOCOUNT ON;

	BEGIN TRY

		IF @flag = 0 OR @flag = 2
		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			-- VALIDAR SI EL CUV EXISTE PARA EL TIPO DE OFERTA SELECCIONADO
			IF NOT EXISTS(
				SELECT 1
				FROM ODS.PRODUCTOCOMERCIAL
				WHERE
					CUV = @CUV2
					AND AnoCampania = @CampaniaID
					AND CODIGOTIPOOFERTA IN (
						SELECT CodigoOferta
						FROM TipoEstrategiaOferta TEO
						INNER JOIN Oferta O ON O.OfertaID = TEO.OfertaID
						WHERE TipoEstrategiaID = @TipoEstrategiaID
				)
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no pertenece al tipo de estrategia seleccionada.', 16, 1)
			END

			DECLARE @FlagNueva INT, @FlagRecoProduc INT, @FlagRecoPerfil INT, @FlagOferta INT
			SET @FlagOferta = -1

			SELECT @FlagNueva = FlagNueva, @FlagRecoProduc = FlagRecoProduc, @FlagRecoPerfil = FlagRecoPerfil 
			FROM TipoEstrategia 
			WHERE TipoEstrategiaID = @TipoEstrategiaID

			IF @FlagRecoProduc = '1' OR @FlagRecoPerfil = '1'

				SET @FlagOferta = 0;

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				CODIGOTIPOOFERTA IN (
					SELECT CODIGOOFERTA
					FROM TIPOESTRATEGIAOFERTA TE
					INNER JOIN OFERTA O ON O.OFERTAID = TE.OFERTAID
					WHERE TIPOESTRATEGIAID = @TipoEstrategiaID OR 0 = @FlagOferta
				)
				AND C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
		END

		ELSE IF @flag = 1
		BEGIN

			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			IF NOT EXISTS(
				SELECT 1
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
    			WHERE C.codigo = @CampaniaID AND CUV = @CUV1
			)
			BEGIN

				RAISERROR('El CUV1 ingresado no existe para la campaña actual.', 16, 1)
			END

			DECLARE @codigoSAP VARCHAR(20) = NULL;
			SELECT TOP 1 @codigoSAP = CodigoProducto
			FROM ods.ProductoComercial pc
			INNER JOIN ods.Campania c ON PC.CAMPANIAID = C.CAMPANIAID
			WHERE C.Codigo = @CampaniaID AND CUV = @CUV2;

			IF NOT EXISTS(SELECT 1 FROM ods.ProductoComercial WHERE CUV = @CUV1 AND CodigoProducto = @codigoSAP)
			BEGIN
			RAISERROR
					('El CUV1 no pertenece al mismo código SAP que el CUV2.', 16, 1)

			END

			SELECT 
				PC.CUV,
				PC.Descripcion DescripcionCUV2,
				PC.PrecioUnitario, 
				'0' IdMatrizComercial,
				'' CodigoSAP,
				1 AS EnMatrizComercial
			FROM ODS.PRODUCTOCOMERCIAL PC
			INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CampaniaID
			WHERE C.CODIGO = @CampaniaID AND PC.CodigoProducto = @codigoSAP AND PC.CUV = @CUV1;

		END

		ELSE IF @flag = 3
		BEGIN

			DECLARE @numeroTallas INT = (SELECT COUNT(1) FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2);

			IF @numeroTallas = 1

			BEGIN
				DELETE FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2
			END

			ELSE IF @numeroTallas > 1

			BEGIN

				SELECT 
					'' CUV,
					'' DescripcionCUV2,
					COUNT(1) PrecioUnitario,
					'' IdMatrizComercial,
					'' CodigoSAP
				FROM TallaColorCUV
				WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUV2 AND Tipo = '0';

			END

			ELSE

			BEGIN
				SELECT
					'' CUV,
					'' DescripcionCUV2,
					-1 PrecioUnitario,
					'' IdMatrizComercial,
					1 AS EnMatrizComercial,
					'' CodigoSAP;
			END

		END

		ELSE IF @flag = 4 OR @flag = 9 OR @flag = 10 OR @flag = 11
		BEGIN
			-- VALIDAR QUE EL CUV EXISTA PARA LA CAMPAÑA ACTUAL
			DECLARE  @codigoEstrategia VARCHAR(5) = '';
			SET @codigoEstrategia = CASE @flag 
				WHEN 4 THEN 'ODD'
				WHEN 9 THEN 'LAN'
				WHEN 10 THEN 'OPM'
				WHEN 11 THEN 'PAD'
			END

			IF NOT EXISTS(
				SELECT 1 
				FROM ods.ProductoComercial PC
				INNER JOIN ods.Campania C ON PC.CampaniaID = C.CampaniaID
				WHERE C.codigo = @CampaniaID AND CUV = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe para la campaña actual.', 16, 1)
			END

			/*
			IF NOT EXISTS(
				SELECT 1 
				FROM ods.OfertasPersonalizadas EP
				WHERE tipopersonalizacion = @codigoEstrategia
				AND aniocampanaventa = @CampaniaID AND cuv = @CUV2
			)
			BEGIN
				RAISERROR('El CUV2 ingresado no existe en la oferta personalizada.', 16, 1)
			END
			*/

			SELECT
				CASE WHEN ISNULL(MC.Descripcion, '') = '' THEN PC.Descripcion ELSE MC.Descripcion END DescripcionCUV2,
				PC.PrecioUnitario,
				mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			FROM ODS.PRODUCTOCOMERCIAL PC
				INNER JOIN ODS.CAMPANIA C ON PC.CAMPANIAID = C.CAMPANIAID
				LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP
			WHERE
				C.CODIGO = @CampaniaID AND PC.CUV = @CUV2;
	
		END 
		ELSE IF @flag = 99
		BEGIN
			SELECT DescripcionCUV2,
				 Precio2 PrecioUnitario,
				 mc.IdMatrizComercial,
				CASE WHEN mc.CodigoSAP IS NULL THEN 0 ELSE 1 END AS EnMatrizComercial, --ISNULL(mc.CodigoSAP, '') CodigoSAP,
				PC.CODIGOPRODUCTO AS CodigoSAP
			 FROM ESTRATEGIA E
			INNER JOIN ODS.CAMPANIA C ON E.CAMPANIAID = C.Codigo
			LEFT JOIN ODS.PRODUCTOCOMERCIAL PC ON PC.CAMPANIAID = C.CAMPANIAID AND PC.CUV = E.CUV2
			LEFT JOIN MATRIZCOMERCIAL MC ON PC.CODIGOPRODUCTO = MC.CODIGOSAP	
			WHERE
				C.CODIGO = @CampaniaID AND E.CUV2 = @CUV2;
		END

	END TRY

	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
	END CATCH
END
GO 

ALTER PROCEDURE [dbo].[FiltrarEstrategia] 
	@EstrategiaID INT = 0,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT
AS
BEGIN
	SELECT
		EstrategiaID,
		TipoEstrategiaID,
		e.CampaniaID,
		CampaniaIDFin,
		NumeroPedido,
		e.Activo,
		ImagenURL,
		LimiteVenta,
		DescripcionCUV2,
		FlagDescripcion,
		e.CUV,
		EtiquetaID,
		Precio,
		FlagCEP,
		CUV2,
		EtiquetaID2,
		Precio2,
		FlagCEP2,
		TextoLibre,
		FlagTextoLibre,
		Cantidad,
		FlagCantidad,
		Zona,
		Orden,
		ISNULL(e.ColorFondo, '') ColorFondo,
		ISNULL(e.FlagEstrella, 0) FlagEstrella,
		mc.CodigoSAP,
		mc.IdMatrizComercial,
		e.PrecioPublico,
		e.Ganancia
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
*/
BEGIN
SET NOCOUNT ON;

	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID VARCHAR(20) = ''

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000), 
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000), 
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
	
	-- Obtener estrategias de recomendadas para ti.
	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania c  with(nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    
		pc.MarcaID,
		te.Orden Orden1,
		op.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)
	
	IF (0 = @cont2)
	BEGIN
	
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
	
		INSERT INTO #TEMPORAL
		SELECT
			EstrategiaID,
			CUV2,
			DescripcionCUV2,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
			e.Precio,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
			Precio2,
			TextoLibre,		
			FlagEstrella,
			ColorFondo,
			e.TipoEstrategiaID,
			e.ImagenURL FotoProducto01,
			te.ImagenEstrategia ImagenURL,
			e.LimiteVenta,    
			pc.MarcaID,
			te.Orden Orden1,
			op.Orden Orden2,
			pc.IndicadorMontoMinimo,
			pc.CodigoProducto,
			0 AS FlagNueva,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar
			, E.EtiquetaID
			, E.EtiquetaID2
			, E.CodigoEstrategia
			, E.TieneVariedad
			, TE.CODIGO
			, TE.DescripcionEstrategia
			, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
			, E.PrecioPublico
			, E.Ganancia
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
*/
BEGIN
SET NOCOUNT ON;

	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID VARCHAR(20) = ''

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000), 
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000), 
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
	
	-- Obtener estrategias de recomendadas para ti.
	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania c  with(nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    
		pc.MarcaID,
		te.Orden Orden1,
		op.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)
	
	IF (0 = @cont2)
	BEGIN
	
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
	
		INSERT INTO #TEMPORAL
		SELECT
			EstrategiaID,
			CUV2,
			DescripcionCUV2,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
			e.Precio,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
			Precio2,
			TextoLibre,		
			FlagEstrella,
			ColorFondo,
			e.TipoEstrategiaID,
			e.ImagenURL FotoProducto01,
			te.ImagenEstrategia ImagenURL,
			e.LimiteVenta,    
			pc.MarcaID,
			te.Orden Orden1,
			op.Orden Orden2,
			pc.IndicadorMontoMinimo,
			pc.CodigoProducto,
			0 AS FlagNueva,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar
			, E.EtiquetaID
			, E.EtiquetaID2
			, E.CodigoEstrategia
			, E.TieneVariedad
			, TE.CODIGO
			, TE.DescripcionEstrategia
			, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
			, E.PrecioPublico
			, E.Ganancia
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
*/
BEGIN
SET NOCOUNT ON;

	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID VARCHAR(20) = ''

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000), 
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000), 
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
	
	-- Obtener estrategias de recomendadas para ti.
	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania c  with(nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		
	INSERT INTO #TEMPORAL
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    
		pc.MarcaID,
		te.Orden Orden1,
		op.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)
	
	IF (0 = @cont2)
	BEGIN
	
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
	
		INSERT INTO #TEMPORAL
		SELECT
			EstrategiaID,
			CUV2,
			DescripcionCUV2,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
			e.Precio,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
			Precio2,
			TextoLibre,		
			FlagEstrella,
			ColorFondo,
			e.TipoEstrategiaID,
			e.ImagenURL FotoProducto01,
			te.ImagenEstrategia ImagenURL,
			e.LimiteVenta,    
			pc.MarcaID,
			te.Orden Orden1,
			op.Orden Orden2,
			pc.IndicadorMontoMinimo,
			pc.CodigoProducto,
			0 AS FlagNueva,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar
			, E.EtiquetaID
			, E.EtiquetaID2
			, E.CodigoEstrategia
			, E.TieneVariedad
			, TE.CODIGO
			, TE.DescripcionEstrategia
			, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
			, E.PrecioPublico
			, E.Ganancia
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
			T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(150),
		CodigoEstrategia varchar(150), 
		TieneVariedad INT,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO