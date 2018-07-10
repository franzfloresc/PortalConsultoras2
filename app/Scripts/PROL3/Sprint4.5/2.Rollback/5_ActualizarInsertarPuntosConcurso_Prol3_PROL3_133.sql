USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.ActualizarInsertarPuntosConcurso_Prol3') IS NOT NULL
BEGIN
	drop procedure dbo.ActualizarInsertarPuntosConcurso_Prol3
END
GO
CREATE PROCEDURE dbo.ActualizarInsertarPuntosConcurso_Prol3
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania VARCHAR(6),
	@CodigoConcurso VARCHAR(8000),
	@PuntosConcurso VARCHAR(8000),
	@PuntosExigidosConcurso VARCHAR(8000) = NULL
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TblConcursosPuntos TABLE 
	(
		COD_CONC VARCHAR(6) NOT NULL,
		PUN_TOTA INT NOT NULL,
		PUN_EXIG INT NOT NULL

		PRIMARY KEY(COD_CONC)
	)

	DECLARE @TblNivelActual TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY(COD_CONC, ORD_NIVE)
	)

	DECLARE @TblNivelSiguiente TABLE
	(
		COD_CONC VARCHAR(6) NOT NULL,
		NUM_NIVE INT NOT NULL,
		PUN_MINI INT NOT NULL,
		ORD_NIVE INT NOT NULL

		PRIMARY KEY (COD_CONC, ORD_NIVE)
	)

	IF LEN(ISNULL(@PuntosConcurso,'')) = 0
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			item, 
			0,
			0
		FROM dbo.fnSplit(@CodigoConcurso,'|')
		WHERE LEN(ISNULL(item,'')) > 0
	END
	ELSE
	BEGIN
		INSERT INTO @TblConcursosPuntos
		(
			COD_CONC,
			PUN_TOTA,
			PUN_EXIG
		)
		SELECT 
			ISNULL(COLA,''), 
			CAST(ISNULL(COLB,'0') AS INT),
			CAST(ISNULL(COLC,'0') AS INT)
		FROM dbo.FN_SPLITEAR(@CodigoConcurso, @PuntosConcurso, @PuntosExigidosConcurso, '|')
		WHERE LEN(ISNULL(COLA,'')) > 0
	END

	INSERT INTO @TblNivelActual
	(
		COD_CONC,
		NUM_NIVE,
		ORD_NIVE
	)
	SELECT 
		CON.COD_CONC,
		INA.NUM_NIVE,
		ROW_NUMBER() OVER(PARTITION BY CON.COD_CONC ORDER BY INA.NUM_NIVE)
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) BETWEEN INA.PUN_MINI AND INA.PUN_MAXI

	INSERT INTO @TblNivelSiguiente
	(
		COD_CONC,
		NUM_NIVE,
		PUN_MINI,
		ORD_NIVE
	)
	SELECT
		INA.COD_CONC,
		INA.NUM_NIVE,
		INA.PUN_MINI,
		ROW_NUMBER() OVER(PARTITION BY INA.COD_CONC ORDER BY INA.NUM_NIVE) AS ORD_NIVE
	FROM @TblConcursosPuntos CON
	INNER JOIN ods.IncentivosNiveles INA(NOLOCK)
	ON CON.COD_CONC = INA.COD_CONC
	LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
	ON CON.COD_CONC = ICP.COD_CONC
	AND ICP.COD_CLIE = @CodigoConsultora 
	WHERE INA.PUN_MINI > CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0)
			
	MERGE dbo.IncentivosPuntosConsultora AS T
	USING
	(
		SELECT 
			@CodigoConsultora AS CodigoConsultora,
			CON.COD_CONC AS CodigoConcurso,
			@CodigoCampania AS CodigoCampania,
			CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntajeTotal,
			ISNULL(ICP.PUN_TOTA,0) AS PuntajeODS,
			INA.NUM_NIVE AS NivelAlcanzado,
			INS.NUM_NIVE AS NivelSiguiente,
			INS.PUN_MINI - CON.PUN_TOTA + ISNULL(ICP.PUN_TOTA,0) AS PuntosFaltantesSiguienteNivel,
			ISNULL(ICP.PUN_VTAS,0) AS PuntosPorVentas,
			ISNULL(ICP.PUN_RETA,0) AS PuntosRetail,
			CON.PUN_EXIG AS PuntajeExigido,
			ICP.DES_ESTA AS EstadoConsultora,
			IPC.TIP_CONC AS TipoConcurso,
			ICP.FEC_VIGE_RETA AS FechaVigenteRetail
		FROM @TblConcursosPuntos CON
		INNER JOIN ods.IncentivosParametriaConcurso IPC (NOLOCK)
		ON IPC.COD_CONC = CON.COD_CONC
		LEFT JOIN ods.IncentivosConsultoraPuntos ICP (NOLOCK)
		ON CON.COD_CONC = ICP.COD_CONC
		AND ICP.COD_CLIE = @CodigoConsultora 
		LEFT JOIN @TblNivelActual INA
		ON CON.COD_CONC = INA.COD_CONC
		AND INA.ORD_NIVE = 1
		LEFT JOIN @TblNivelSiguiente INS
		ON CON.COD_CONC = INS.COD_CONC
		AND INS.ORD_NIVE = 1
	) AS S
	ON (T.CodigoConsultora = S.CodigoConsultora AND T.CodigoConcurso = S.CodigoConcurso AND T.CampaniaInicio = S.CodigoCampania)
	WHEN MATCHED THEN
		UPDATE SET 
			T.NivelAlcanzado = S.NivelAlcanzado,
			T.NivelSiguiente = S.NivelSiguiente,
			T.PuntosFaltantesSiguienteNivel = S.PuntosFaltantesSiguienteNivel, 
			T.PuntosPorVentas = S.PuntosPorVentas,
			T.PuntosRetail = S.PuntosRetail,
			T.PuntajeTotal = S.PuntajeTotal,
			T.PuntajeODS = S.PuntajeODS, 
			T.EstadoConsultora = S.EstadoConsultora,
			T.TipoConcurso = S.TipoConcurso,
			T.FechaVigenteRetail = S.FechaVigenteRetail,
			T.PuntajeExigido = S.PuntajeExigido
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
		(
			CodigoConsultora,
			CodigoConcurso,
			NivelAlcanzado,
			NivelSiguiente,
			PuntosFaltantesSiguienteNivel,
			PuntosPorVentas,
			PuntosRetail,
			PuntajeTotal,
			PuntajeODS, 
			CampaniaInicio, 
			CampaniaFinal,
			CampaniaDespachoInicial, 
			CampaniaDespachoFinal,
			EstadoConsultora, 
			TipoConcurso,
			FechaVigenteRetail,
			PuntajeExigido
		)
		VALUES 
		(
			S.CodigoConsultora,
			S.CodigoConcurso, 
			S.NivelAlcanzado,
			S.NivelSiguiente, 
			S.PuntosFaltantesSiguienteNivel, 
			S.PuntosPorVentas, 
			S.PuntosRetail, 
			S.PuntajeTotal, 
			S.PuntajeODS, 
			S.CodigoCampania, 
			S.CodigoCampania,
			S.CodigoCampania, 
			S.CodigoCampania,
			S.EstadoConsultora, 
			S.TipoConcurso,  
			S.FechaVigenteRetail,
			S.PuntajeExigido
		);

	SET NOCOUNT OFF
END
GO