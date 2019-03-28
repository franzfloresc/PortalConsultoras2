USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.ObtenerIncentivosConsultoraEstrategia', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.ObtenerIncentivosConsultoraEstrategia
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoCampaniaAnterior INT

	DECLARE @TblConcurso TABLE
	(
		CampaniaID INT NOT NULL,
		CampaniaIDInicio INT NOT NULL,
		CampaniaIDFin INT NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL,
		TipoConcurso VARCHAR(3) NOT NULL,
		PuntosAcumulados INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		IndicadorPremioAcumulativo BIT NOT NULL,
		NivelAlcanzado INT NOT NULL,
		CampaniaIDPremiacion INT NULL,
		PuntajeExigido INT NOT NULL,
		PuntosFaltantesSiguienteNivel INT NOT NULL

		PRIMARY KEY(CodigoConcurso)
	)

	DECLARE @TblNiveles TABLE
	(
		CodigoConcurso VARCHAR(6) NOT NULL,
		CodigoNivel INT NOT NULL,
		PuntosNivel INT NOT NULL,
		PuntosFaltantes INT NOT NULL,
		IndicadorNivelElectivo INT NOT NULL,
		IndicadorPremiacionPedido BIT NOT NULL,
		MontoPremiacionPedido NUMERIC(13,2) NOT NULL,
		IndicadorBelCenter BIT NOT NULL,
		FechaVentaRetail DATE NULL,
		PuntosExigidos INT NOT NULL,
		PuntosExigidosFaltantes INT NOT NULL

		PRIMARY KEY(CodigoConcurso, CodigoNivel)
	)

	DECLARE @TblOrdenConcurso TABLE
	(
		IdTabla SMALLINT IDENTITY(1,1) NOT NULL,
		CodigoConcurso VARCHAR(6) NOT NULL

		PRIMARY KEY (IdTabla)
	)

	SELECT 
		@CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1)
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT 
		@CodigoCampania,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.CodigoConcurso,
		INC.TipoConcurso,
		INC.PuntajeTotal,
		0,
		0,
		0,
		NULL,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NivelAlcanzado,0),
		NULL,
		ISNULL(INC.PuntajeExigido,0),
		ISNULL(INC.PuntosFaltantesSiguienteNivel,0)
	FROM dbo.IncentivosPuntosConsultora INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.CodigoConcurso = PAR.COD_CONC
	WHERE INC.CodigoConsultora = @CodigoConsultora
	AND CAST(INC.CampaniaInicio AS INT) = @CodigoCampania

	INSERT INTO @TblConcurso
	(
		CampaniaID,
		CampaniaIDInicio,
		CampaniaIDFin,
		CodigoConcurso,
		TipoConcurso,
		PuntosAcumulados,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		IndicadorPremioAcumulativo,
		NivelAlcanzado,
		CampaniaIDPremiacion,
		PuntajeExigido,
		PuntosFaltantesSiguienteNivel
	)
	SELECT
		@CodigoCampaniaAnterior,
		PAR.CAM_INIC,
		PAR.CAM_FINA,
		INC.COD_CONC,
		INC.TIP_CONC,
		INC.PUN_TOTA,
		PAR.IND_PREM_PEDI,
		CASE WHEN PAR.MON_PREM_PEDI > 1 THEN PAR.MON_PREM_PEDI ELSE 0 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN 0
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN 0
			ELSE 1 END,
		CASE WHEN INC.FEC_VIGE_RETA IS NULL THEN NULL
			WHEN INC.FEC_VIGE_RETA < CAST(dbo.fnObtenerFechaHoraPais() AS DATE) THEN NULL
			ELSE INC.FEC_VIGE_RETA END,
		PAR.IND_PREM_ACUM,
		ISNULL(INC.NIV_ALCA,0),
		PAR.DES_INIC,
		0,
		ISNULL(INC.PUN_FALT_NIVS,0)
	FROM ods.IncentivosConsultoraPuntos INC (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PAR (NOLOCK)
	ON INC.COD_CONC = PAR.COD_CONC
	INNER JOIN dbo.IncentivosPuntosConsultora ACT (NOLOCK)
	ON INC.COD_CONC = ACT.CodigoConcurso
	AND INC.COD_CLIE = ACT.CodigoConsultora
	WHERE INC.COD_CLIE = @CodigoConsultora
	AND INC.DES_ESTA = 'EN COMPETENCIA'
	AND CAST(PAR.DES_INIC AS INT) >= @CodigoCampania
	AND INC.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.CodigoConcurso = INC.COD_CONC)

	INSERT INTO @TblNiveles
	(
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		PuntosFaltantes,
		IndicadorNivelElectivo,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		PuntosExigidos,
		PuntosExigidosFaltantes
	)
	SELECT
		NIV.COD_CONC,
		NIV.NUM_NIVE,
		NIV.PUN_MINI,
		NIV.PUN_MINI - CON.PuntosAcumulados,
		NIV.IND_NIVE_ELEC,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.IndicadorPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados >= NIV.PUN_MINI 
				THEN CON.MontoPremiacionPedido
				ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.IndicadorBelCenter 
			ELSE 0 END,
		CASE WHEN CON.PuntosAcumulados < NIV.PUN_MINI 
			THEN CON.FechaVentaRetail 
			ELSE NULL END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) ELSE 0 END,
		CASE WHEN CON.CampaniaID = @CodigoCampania THEN ISNULL(NIV.PUN_EXIG,0) - CON.PuntajeExigido ELSE 0 END 
	FROM ods.IncentivosNiveles NIV (NOLOCK)
	INNER JOIN @TblConcurso CON 
	ON NIV.COD_CONC = CON.CodigoConcurso

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE CampaniaID = @CodigoCampaniaAnterior
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel > 0
	AND CampaniaID = @CodigoCampania
	ORDER BY PuntosFaltantesSiguienteNivel

	INSERT INTO @TblOrdenConcurso
	SELECT
		CodigoConcurso
	FROM @TblConcurso
	WHERE PuntosFaltantesSiguienteNivel = 0
	AND CampaniaID = @CodigoCampania

	--CONCURSOS
	SELECT 
		CON.CampaniaID,
		CON.CampaniaIDInicio,
		CON.CampaniaIDFin,
		CON.CodigoConcurso,
		CON.TipoConcurso,
		CON.PuntosAcumulados,
		CON.IndicadorPremioAcumulativo,
		CON.NivelAlcanzado,
		CON.CampaniaIDPremiacion,
		CON.PuntajeExigido
	FROM @TblConcurso CON
	INNER JOIN @TblOrdenConcurso ORD
	ON CON.CodigoConcurso = ORD.CodigoConcurso
	ORDER BY ORD.IdTabla

	--NIVELES
	SELECT 
		CodigoConcurso,
		CodigoNivel,
		PuntosNivel,
		CASE WHEN PuntosFaltantes < 0 THEN 0 ELSE PuntosFaltantes END AS PuntosFaltantes,
		IndicadorPremiacionPedido,
		MontoPremiacionPedido,
		IndicadorBelCenter,
		FechaVentaRetail,
		CAST(IndicadorNivelElectivo AS BIT) AS IndicadorNivelElectivo,
		PuntosExigidos,
		CASE WHEN PuntosExigidosFaltantes < 0 THEN 0 ELSE PuntosExigidosFaltantes END AS PuntosExigidosFaltantes
	FROM @TblNiveles

	--PREMIOS
	SELECT 
		NIV.CodigoConcurso,
		NIV.CodigoNivel,
		PRE.COD_PREM AS CodigoPremio,
		LTRIM(RTRIM(dbo.InitCap(PRE.DES_PROD))) AS DescripcionPremio,
		PRE.NUM_PREM AS NumeroPremio,
		ISNULL(PRE.URLImagen,'') AS ImagenPremio
	FROM ods.IncentivosPremiosNivel PRE (NOLOCK)
	INNER JOIN @TblNiveles NIV
	ON PRE.COD_CONC = NIV.CodigoConcurso
	AND PRE.NUM_NIVE = NIV.CodigoNivel
	ORDER BY NIV.CodigoConcurso, NIV.CodigoNivel, PRE.COD_PREM

	SET NOCOUNT OFF
END
GO

