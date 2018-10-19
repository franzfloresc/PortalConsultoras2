USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.ObtenerProgramaNuevasXConsultora') IS NOT NULL
BEGIN
	drop procedure dbo.ObtenerProgramaNuevasXConsultora
END
GO
CREATE PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
@CodigoConsultora VARCHAR(15),
@CodigoCampania INT,
@CodigoRegion VARCHAR(4),
@CodigoZona VARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	;WITH CTE_CONSULTORA_NIVEL
	AS
	(
		SELECT 
			CON.Codigo AS CodigoConsultora,
			@CodigoCampania AS CodigoCampania,
			CASE WHEN CON.ConsecutivoNueva = 0 AND (CON.IdEstadoActividad = 1 OR CON.IdEstadoActividad = 7)
				THEN '01'
	
		WHEN CON.ConsecutivoNueva = 1
				THEN '02'  
			WHEN CON.ConsecutivoNueva = 2
				THEN '03'  
			WHEN CON.ConsecutivoNueva = 3
				THEN '04'  
			WHEN CON.ConsecutivoNueva = 4
				THEN '05'  
			WHEN CON.ConsecutivoNueva = 5
				THEN '06'  
			WHEN CON.ConsecutivoNueva = 6
				THEN '07'
			ELSE '00' END AS CodigoNivel,
			@CodigoRegion AS CodigoRegion,
			@CodigoZona AS CodigoZona
		FROM ods.Consultora CON (NOLOCK)
		WHERE CON.Codigo = @CodigoConsultora
	)
	,CTE_CONSULTORA_PARTICIPA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel,
			CPN.Participa,
			ROW_NUMBER() OVER(PARTITION BY CPN.CodigoConsultora ORDER BY CPN.Campania DESC) AS ID
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoConsultora = CPN.CodigoConsultora
		WHERE CON.CodigoNivel BETWEEN '02' AND '06'
	)
	,CTE_CONSULTORA_PROGRAMA
	AS
	(
		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		INNER JOIN ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK)
		ON CPN.CodigoPrograma = CPNUA.CodigoPrograma
		AND CON.CodigoRegion = CPNUA.CodigoRegion
		AND CON.CodigoZona = ISNULL(CPNUA.CodigoZona, CON.CodigoZona)
		WHERE CON.CodigoNivel = '01'

		UNION ALL

		SELECT 
			CON.CodigoConsultora,
			CON.CodigoCampania,
			CPN.CodigoPrograma,
			CON.CodigoNivel
		FROM CTE_CONSULTORA_NIVEL CON
		INNER JOIN ods.ConfiguracionProgramaNuevas CPN (NOLOCK)
		ON CON.CodigoCampania = CPN.CampanaCarga
		WHERE CON.CodigoNivel = '01'
		AND NOT EXISTS(SELECT 1 FROM ods.ConfiguracionProgramaNuevasUA CPNUA (NOLOCK) WHERE CPN.CodigoPrograma = CPNUA.CodigoPrograma)

		UNION ALL

		SELECT 
			CodigoConsultora,
			CodigoCampania,
			CodigoPrograma,
			CodigoNivel
		FROM CTE_CONSULTORA_PARTICIPA
		WHERE ID = 1
		AND Participa = 1

		--SELECT 
		--	CON.CodigoConsultora,
		--	CON.CodigoCampania,
		--	CPN.CodigoPrograma,
		--	CON.CodigoNivel
		--FROM CTE_CONSULTORA_NIVEL CON
		--INNER JOIN ods.ConsultorasProgramaNuevas CPN (NOLOCK)
		--ON CON.CodigoConsultora = CPN.CodigoConsultora
		--AND CON.CodigoCampania = CPN.Campania
		--WHERE CON.CodigoNivel BETWEEN '02' AND '06'
		--AND CPN.Participa = 1
	)
	INSERT INTO dbo.IncentivosConsultoraProgramaNuevas
	(
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		TipoConcurso
	)
	SELECT
		CodigoConsultora,
		CodigoCampania,
		CodigoPrograma,
		CodigoNivel,
		'P'
	FROM CTE_CONSULTORA_PROGRAMA

	SELECT
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	FROM dbo.IncentivosConsultoraProgramaNuevas
	WHERE CodigoConsultora = @CodigoConsultora

	SET NOCOUNT OFF
END
GO