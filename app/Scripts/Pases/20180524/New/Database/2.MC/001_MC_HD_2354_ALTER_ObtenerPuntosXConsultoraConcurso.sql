USE BelcorpPeru
go

ALTER PROCEDURE dbo.ObtenerPuntosXConsultoraConcurso 
(
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania INT

)
AS
-- DECLARE @CodigoConsultora VARCHAR(15) = '042412058' , @CodigoCampania INT = 201807 ;

BEGIN
	SET NOCOUNT ON

	DECLARE @Estado VARCHAR(30) = 'EN COMPETENCIA',
			@CodigoCampaniaAnterior INT,
			@Simbolo VARCHAR(5)

	DECLARE @TblConcurso TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		COD_CLIE VARCHAR(15) NOT NULL,
		NIV_ALCA INT NULL,
		NivelSiguiente INT NULL,
		PUN_FALT_NIVS INT NULL,
		PUN_VTAS INT NULL,
		PUN_RETA INT NULL,
		PUN_TOTA INT NULL,
		PuntajeODS INT NULL,
		COD_CAMPANIA VARCHAR(6) NOT NULL,
		TIP_CONC VARCHAR(3) NULL,
		FEC_VIGE_RETA DATE NULL,
		EsCampaniaAnterior BIT NOT NULL,
		MON_PREM_PEDI NUMERIC(13,2) NULL,
		IND_PREM_PEDI BIT NULL,
		IND_PREM_ACUM BIT NULL,
		NUMERO_NIVELES INT NULL,
		SIMBOLO VARCHAR(5) NOT NULL,
		CampaniaInicio VARCHAR(6) NULL,
		CampaniaFinal VARCHAR(6) NULL,
		NivelPremio INT NULL,
		MostrarUNPremio BIT NOT NULL
		PRIMARY KEY(COD_CONC, COD_CAMPANIA)
	);

	SELECT  @Simbolo = simbolo, @CodigoCampaniaAnterior = FFVV.fnGetCampaniaAnterior(@CodigoCampania,1) FROM dbo.Pais (NOLOCK) WHERE EstadoActivo = 1



	-- Obtener concurso campa�a actual.
	INSERT INTO @TblConcurso
	(
		COD_CONC,
		COD_CLIE,
		NIV_ALCA,
		NivelSiguiente,
		PUN_FALT_NIVS,
		PUN_VTAS,
		PUN_RETA,
		PUN_TOTA,
		PuntajeODS,
		COD_CAMPANIA,
		TIP_CONC,
		FEC_VIGE_RETA,
		EsCampaniaAnterior,
		MON_PREM_PEDI,
		IND_PREM_PEDI,
		IND_PREM_ACUM,
		NUMERO_NIVELES,
		SIMBOLO,
		CampaniaInicio,
		CampaniaFinal,
		NivelPremio,
		MostrarUNPremio
	)
	SELECT
		CP.CodigoConcurso,
		@CodigoConsultora,
		CP.NivelAlcanzado,
		CP.NivelSiguiente,
		CP.PuntosFaltantesSiguienteNivel,
		CP.PuntosPorVentas,
		CP.PuntosRetail,
		CP.PuntajeTotal,
		CP.PuntajeODS,
		@CodigoCampania,
		CP.TipoConcurso,
		CP.FechaVigenteRetail,
		0,
		PC.MON_PREM_PEDI,
		PC.IND_PREM_PEDI,
		PC.IND_PREM_ACUM,
		PC.NUM_NIVE,
		@Simbolo,
		/*
		CP.CampaniaInicio,
		CP.CampaniaFinal,
		*/
		PC.CAM_INIC,
		PC.CAM_FINA,
		CASE WHEN CP.NivelAlcanzado IS NULL
			THEN CP.NivelSiguiente
			ELSE CP.NivelAlcanzado END,
		CASE WHEN CP.NivelAlcanzado IS NULL
			THEN 0
			ELSE 1 END
	FROM dbo.IncentivosPuntosConsultora CP (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PC (NOLOCK) ON CP.CodigoConcurso = PC.COD_CONC
	WHERE CP.CodigoConsultora = @CodigoConsultora
	AND CAST(CP.CampaniaInicio AS INT) = CAST(@CodigoCampania AS INT)
	-- AND CP.TipoConcurso = 'X' -- comentar





	-- Obtener concurso campa�a anterior.
	INSERT INTO @TblConcurso
	(
		COD_CONC,
		COD_CLIE,
		NIV_ALCA,
		NivelSiguiente,
		PUN_FALT_NIVS,
		PUN_VTAS,
		PUN_RETA,
		PUN_TOTA,
		PuntajeODS,
		COD_CAMPANIA,
		TIP_CONC,
		FEC_VIGE_RETA,
		EsCampaniaAnterior,
		MON_PREM_PEDI,
		IND_PREM_PEDI,
		IND_PREM_ACUM,
		NUMERO_NIVELES,
		SIMBOLO,
		CampaniaInicio,
		CampaniaFinal,
		NivelPremio,
		MostrarUNPremio
	)
	SELECT 
		CP.COD_CONC,
		@CodigoConsultora,
		CP.NIV_ALCA,
		CP.NIV_SIGU,
		CP.PUN_FALT_NIVS,
		CP.PUN_VTAS,
		CP.PUN_RETA,
		CP.PUN_TOTA,
		CP.PUN_TOTA,
		@CodigoCampaniaAnterior,
		CP.TIP_CONC,
		CP.FEC_VIGE_RETA,
		1,
		PC.MON_PREM_PEDI,
		PC.IND_PREM_PEDI,
		PC.IND_PREM_ACUM,
		PC.NUM_NIVE,
		@Simbolo,
		CP.CAM_INIC,
		CP.CAM_FINA,
		CASE WHEN CP.NIV_ALCA IS NULL
			THEN CP.NIV_SIGU
			ELSE CP.NIV_ALCA END,
		CASE WHEN CP.NIV_ALCA IS NULL
			THEN 0
			ELSE 1 END
	FROM ods.IncentivosConsultoraPuntos CP (NOLOCK)
	INNER JOIN ods.IncentivosParametriaConcurso PC (NOLOCK) ON CP.COD_CONC = PC.COD_CONC
	WHERE CP.COD_CLIE = @CodigoConsultora
	AND CP.DES_ESTA = @Estado
	-- AND @CodigoCampaniaAnterior BETWEEN CAST(CP.CAM_INIC AS INT) AND CAST(CP.CAM_FINA AS INT)
	-- AND CP.TIP_CONC = 'X' -- comentar 
	AND CAST(PC.DES_INIC AS INT) >= @CodigoCampania
	AND CP.PUN_TOTA > 0
	AND NOT EXISTS(SELECT 1 FROM @TblConcurso TMP WHERE TMP.COD_CONC = CP.COD_CONC)


	

	SELECT 
		COD_CONC,
		COD_CLIE,
		NIV_ALCA,
		NivelSiguiente,
		PUN_FALT_NIVS,
		PUN_VTAS,
		PUN_RETA,
		PUN_TOTA,
		PuntajeODS,
		COD_CAMPANIA,
		TIP_CONC,
		FEC_VIGE_RETA,
		EsCampaniaAnterior,
		MON_PREM_PEDI,
		IND_PREM_PEDI,
		IND_PREM_ACUM,
		NUMERO_NIVELES,
		SIMBOLO,
		CampaniaInicio,
		CampaniaFinal
	FROM @TblConcurso


	
	-- Obtener premios del concurso actual.
	
	SELECT 
		ICN.COD_CONC,
		ICN.NUM_NIVE,
		ICN.PUN_MINI,
		ICNP.COD_PREM,
		ICNP.DES_PROD
	FROM ods.IncentivosNiveles ICN (NOLOCK)
	INNER JOIN ods.IncentivosPremiosNivel ICNP (NOLOCK) ON ICN.COD_CONC = ICNP.COD_CONC AND ICNP.NUM_NIVE = ICN.NUM_NIVE
	INNER JOIN @TblConcurso CON ON CON.COD_CONC = ICN.COD_CONC
	WHERE ICN.NUM_NIVE <= CASE WHEN CON.MostrarUNPremio = 0
							THEN CON.NivelPremio
							ELSE CON.NivelPremio + 1 END
	AND CON.EsCampaniaAnterior = 0
	UNION ALL 
	-- Obtener premios del concurso Anterior.

	SELECT 
		ICN.COD_CONC,
		ICN.NUM_NIVE,
		ICN.PUN_MINI,
		'000' AS COD_PREM,
		STUFF((

				SELECT ',' + PR1.DES_PROD
				FROM ods.IncentivosPremiosNivel PR1 (NOLOCK)
				WHERE ICN.COD_CONC = PR1.COD_CONC AND ICN.NUM_NIVE = PR1.NUM_NIVE
				FOR XML PATH('')
				), 1, 1, '') AS DES_PROD
	FROM ods.IncentivosNiveles ICN (NOLOCK)
	INNER JOIN ods.IncentivosPremiosNivel ICNP (NOLOCK) ON ICN.COD_CONC = ICNP.COD_CONC AND ICNP.NUM_NIVE = ICN.NUM_NIVE
	INNER JOIN @TblConcurso CON ON CON.COD_CONC = ICN.COD_CONC
	WHERE CON.EsCampaniaAnterior = 1
	GROUP BY ICN.COD_CONC, ICN.NUM_NIVE ,ICN.PUN_MINI
	
	
	SET NOCOUNT OFF

END
