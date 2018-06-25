USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosProgramaNuevasConsultora', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosProgramaNuevasConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@ConsultoraID BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ImportePedido MONEY,
			@MontoMinimoPedido DECIMAL(15,2)

	DECLARE @TBL_PROGRAMA TABLE
	(
		CampaniaID INT NOT NULL,
		CodigoConcurso VARCHAR(15) NOT NULL, 
		CodigoNivel CHAR(2) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		ImportePedido MONEY NOT NULL,
		TextoCupon VARCHAR(500) NOT NULL,
		TextoCuponIndependiente VARCHAR(500) NOT NULL

		PRIMARY KEY (CodigoConcurso)
	)

	DECLARE @TBL_NIVEL TABLE
	(
		CodigoNivel CHAR(2) NOT NULL

		PRIMARY KEY (CodigoNivel)
	)

	DECLARE @TBL_ESTRATEGIA TABLE
	(
		CUV2 VARCHAR(20) NOT NULL,
		CampaniaID INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		TextoLibre VARCHAR(800) NOT NULL,
		DescripcionCUV2 VARCHAR(800) NOT NULL,
		Precio2 DECIMAL(12,2) NOT NULL,
		Ganancia DECIMAL(12,2) NOT NULL,
		ImagenURL VARCHAR(800) NOT NULL,
		Orden INT NOT NULL

		PRIMARY KEY (CUV2, CampaniaID)
	)

	INSERT INTO @TBL_NIVEL VALUES ('01'),('02'),('03'),('04'),('05'),('06')

	SELECT @ImportePedido = ImporteTotal
	FROM dbo.PedidoWeb (NOLOCK)
	WHERE CampaniaID = @CodigoCampania
	AND ConsultoraID = @ConsultoraID

	SELECT @MontoMinimoPedido = MontoMinimoPedido
	FROM ods.Consultora (NOLOCK)
	WHERE ConsultoraID = @ConsultoraID

	--ESTRATEGIA
	INSERT INTO @TBL_ESTRATEGIA
	(
		CUV2,
		CampaniaID,
		CampaniaIDFin,
		TextoLibre,
		DescripcionCUV2,
		Precio2,
		Ganancia,
		ImagenURL,
		Orden
	)
	SELECT
		EST.CUV2,
		EST.CampaniaID,
		EST.CampaniaIDFin,
		ISNULL(EST.TextoLibre,''),
		dbo.InitCap(EST.DescripcionCUV2),
		EST.Precio2,
		EST.Ganancia,
		EST.ImagenURL,
		ISNULL(EST.Orden,0)
	FROM dbo.Estrategia EST (NOLOCK)
	INNER JOIN dbo.TipoEstrategia TE (NOLOCK)
	ON EST.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE TE.Codigo = '021'
	AND EST.Activo = 1

	INSERT INTO @TBL_PROGRAMA
	(
		CampaniaID,
		CodigoConcurso,
		CodigoNivel,
		TipoConcurso,
		ImportePedido,
		TextoCupon,
		TextoCuponIndependiente
	)
	SELECT 
		ICPN.CodigoCampania,
		ICPN.CodigoPrograma, 
		ICPN.CodigoNivel,
		ICPN.TipoConcurso,
		ISNULL(@ImportePedido,0),
		ISNULL(CON.TextoCupon,''),
		ISNULL(CON.TextoCuponIndependiente,'')
	FROM dbo.IncentivosConsultoraProgramaNuevas ICPN (NOLOCK)
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp CON (NOLOCK)
	ON ICPN.CodigoPrograma = CON.CodigoPrograma
	AND CON.CodigoNivel IS NULL
	WHERE CodigoConsultora = @CodigoConsultora

	--PROGRAMA
	SELECT 
		P.CampaniaID,
		P.CodigoConcurso,
		P.CodigoNivel,
		P.TipoConcurso,
		P.ImportePedido,
		P.TextoCupon,
		P.TextoCuponIndependiente,
		C.ArchivoBannerCupon,
		C.ArchivoBannerPremio
	FROM @TBL_PROGRAMA P
	LEFT JOIN dbo.ConfiguracionProgramaNuevasApp C (NOLOCK)
	ON P.CodigoConcurso = C.CodigoPrograma
	AND P.CodigoNivel = C.CodigoNivel

	--NIVEL
	SELECT
		PRO.CodigoConcurso,
		NIV.CodigoNivel,
		ISNULL(EXGP.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoPremio,
		ISNULL(EXGC.MontoExigenciaVentas, @MontoMinimoPedido) AS MontoExigidoCupon
	FROM @TBL_PROGRAMA PRO
	INNER JOIN @TBL_NIVEL NIV 
	ON 1 = 1
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGP (NOLOCK)
	ON EXGP.CodigoPrograma = PRO.CodigoConcurso
	AND EXGP.CodigoNivel = NIV.CodigoNivel
	AND EXGP.TipoCupon = 'B'
	LEFT JOIN ods.ExigenciaVentasProgramaNuevas EXGC (NOLOCK)
	ON EXGC.CodigoPrograma = PRO.CodigoConcurso
	AND EXGC.CodigoNivel = NIV.CodigoNivel
	AND EXGC.TipoCupon = 'C'

	--PREMIO
	SELECT 
		P.CodigoConcurso,
		PPN.CodigoNivel,
		PPN.CUV,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE dbo.InitCap(PPN.DescripcionProducto) END AS DescripcionProducto,
		PPN.IndicadorKitNuevas,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE PPN.PrecioUnitario END AS PrecioUnitario,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM @TBL_PROGRAMA P
	INNER JOIN ods.PremiosProgramaNuevas PPN (NOLOCK)
	ON P.CodigoConcurso = PPN.CodigoPrograma
	AND P.CampaniaID = PPN.AnoCampana
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = PPN.CUV
	AND PPN.AnoCampana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	WHERE PPN.IndicadorActivo = 1
	ORDER BY EST.Orden

	--CUPON
	;WITH CTE_CUPON
	AS
	(
		SELECT 
			P.CodigoConcurso,
			CPN.CodigoNivel,
			CPN.CodigoCupon,
			CPN.CodigoVenta,
			dbo.InitCap(CPN.DescripcionProducto) AS DescripcionProducto,
			CPN.UnidadesMaximas,
			CPN.IndicadorKit,
			CPN.IndicadorCuponIndependiente,
			CPN.PrecioUnitario,
			CPN.NumeroCampanasVigentes,
			CPN.Campana
		FROM @TBL_PROGRAMA P
		INNER JOIN ods.CuponesProgramaNuevas CPN (NOLOCK)
		ON P.CodigoConcurso = CPN.CodigoPrograma
		AND P.CampaniaID = CPN.Campana
		WHERE ISNULL(CPN.CodigoVenta, '0') <> '0' 
		AND ISNULL(CPN.UnidadesMaximas, '0') <> '0'
	)
	,CTE_CUPON_VIGENCIA
	AS
	(
		SELECT 
			CodigoConcurso, 
			CodigoNivel, 
			CodigoCupon,
			CodigoVenta,
			DescripcionProducto,
			UnidadesMaximas,
			IndicadorKit,
			IndicadorCuponIndependiente,
			PrecioUnitario,
			NumeroCampanasVigentes,
			Campana,
			CodigoNivel AS CodigoNivelCalculo, 
			NumeroCampanasVigentes AS NumeroCampanasVigentesCalculo
		FROM CTE_CUPON

		UNION ALL

		SELECT 
			A.CodigoConcurso, 
			A.CodigoNivel, 
			A.CodigoCupon, 
			A.CodigoVenta,
			A.DescripcionProducto,
			A.UnidadesMaximas,
			A.IndicadorKit,
			A.IndicadorCuponIndependiente,
			A.PrecioUnitario,
			A.NumeroCampanasVigentes,
			A.Campana,
			CAST(RIGHT(REPLICATE('0',2) + LTRIM(STR(CAST(A.CodigoNivelCalculo AS INT) + 1)), 2) AS CHAR(2)), 
			A.NumeroCampanasVigentesCalculo - 1
		FROM CTE_CUPON_VIGENCIA A
		INNER JOIN CTE_CUPON B
		ON A.CodigoConcurso = B.CodigoConcurso
		AND A.CodigoNivel = B.CodigoNivel
		AND A.CodigoCupon = B.CodigoCupon
		AND A.NumeroCampanasVigentesCalculo > 1
	)
	SELECT 
		CUP.Campana,
		CUP.CodigoConcurso,
		CUP.CodigoNivelCalculo AS CodigoNivel,
		CUP.CodigoCupon,
		CUP.CodigoVenta,
		CASE WHEN LEN(ISNULL(EST.DescripcionCUV2,'')) > 0 THEN ISNULL(EST.DescripcionCUV2,'') ELSE CUP.DescripcionProducto END AS DescripcionProducto,
		CUP.UnidadesMaximas,
		CUP.IndicadorKit,
		CUP.IndicadorCuponIndependiente,
		CASE WHEN ISNULL(EST.Precio2,0) > 0 THEN ISNULL(EST.Precio2,0) ELSE CUP.PrecioUnitario END AS PrecioUnitario,
		CUP.NumeroCampanasVigentes,
		ISNULL(EST.TextoLibre,'') AS TextoLibre,
		ISNULL(EST.Ganancia,0) AS Ganancia,
		ISNULL(EST.ImagenURL,'') AS ImagenURL
	FROM CTE_CUPON_VIGENCIA CUP
	INNER JOIN @TBL_ESTRATEGIA EST
	ON EST.CUV2 = CUP.CodigoCupon
	AND CUP.Campana BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
	ORDER BY EST.Orden
	OPTION (MAXRECURSION 0)

	SET NOCOUNT OFF
END
GO

