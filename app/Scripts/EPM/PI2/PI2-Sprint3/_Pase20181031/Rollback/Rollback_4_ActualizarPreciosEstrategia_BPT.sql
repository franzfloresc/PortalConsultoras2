GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE [dbo].[ActualizarPreciosEstrategia]
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON

	DECLARE @CampaniaActual INT =0 --= 201810
	DECLARE @CampaniaSiguiente INT = 0
	DECLARE @CampaniaSubSiguiente INT = 0

	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);

	/****INICIO - Crear Temporales****/
	BEGIN
		/* #EstrategiaTemporal */
		CREATE TABLE #EstrategiaTemporal(
			EstrategiaTemporalId	int null
			,CampaniaId				int  null
			,CUV					varchar(5) null
			,PrecioOferta			decimal(18,2) null
			,PrecioTachado			decimal(18,2) null
			,PrecioPublico			decimal(18,2) null
			,Ganancia				decimal(18,2) null
			,Niveles				varchar(200) null
		)
		INSERT INTO #EstrategiaTemporal
		SELECT
			EstrategiaId
			,CampaniaId
			,CUV2
			,Precio2
			,Precio
			,PrecioPublico
			,Ganancia
			,Niveles
		FROM Estrategia ET
		WHERE
		ET.CampaniaId IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoComercial*/
		CREATE TABLE #ProductoComercial(
			CampaniaId			int null
			,CUV				varchar(50) null
			,PrecioUnitario		numeric(12,2) null
			,FactorRepeticion	int null
			,IndicadorDigitable	bit null
			,AnoCampania		int null
			,IndicadorPreUni	numeric(12,2) null
			,CodigoFactorCuadre	numeric(12,2) null
			,EstrategiaIdSicc	int null
			,CodigoOferta		int null
			,NumeroGrupo		int null
			,NumeroNivel		int null
		)
		INSERT INTO #ProductoComercial
		SELECT
			PC.AnoCampania
			,PC.CUV
			,PC.PrecioUnitario
			,PC.FactorRepeticion
			,PC.IndicadorDigitable
			,PC.AnoCampania
			,PC.IndicadorPreUni
			,PC.CodigoFactorCuadre
			,PC.EstrategiaIdSicc
			,PC.CodigoOferta
			,PC.NumeroGrupo
			,PC.NumeroNivel
		FROM ODS.ProductoComercial PC
		WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

		/* #ProductoNivel */
		CREATE TABLE #ProductoNivel(
			CUV			varchar(5) null
			,CampaniaId	int null
			,Nivel		int null
			,Precio		numeric(12,2) null
		)
		INSERT INTO #ProductoNivel
		SELECT
			ET.CUV
			,ET.CampaniaId
			,Nivel = PN.FactorCuadre
			,Precio = PN.PrecioUnitario
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV
				AND ET.CampaniaId = PC.CampaniaId
			JOIN ODS.ProductoNivel PN
				ON PC.NumeroNivel = PN.NumeroNivel
				AND PN.Campana = PC.CampaniaId
				AND PN.FactorCuadre > 1
		GROUP BY ET.CUV, ET.CampaniaId, PN.FactorCuadre, PN.PrecioUnitario
	END
	/****FIN - Crear Temporales****/

	/****INICIO - Cálculo de Ganancia****/
	BEGIN
		/* #EstrategiaTemporal_2001 */
		CREATE TABLE #EstrategiaTemporal_2001(
			EstrategiaTemporalId	int
			,PrecioPublico			decimal(18,2)
			,Ganancia				decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2001
		SELECT
			ET.EstrategiaTemporalId
			,PrecioPublico = PC.PrecioUnitario * PC.FactorRepeticion
			,Ganancia = (PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion
		FROM #EstrategiaTemporal ET
			JOIN #ProductoComercial PC
				ON ET.CUV = PC.CUV AND ET.CampaniaId = PC.CampaniaId
			AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
			AND PC.FactorRepeticion >= 1

		/* #EstrategiaTemporal_2002 */
		CREATE TABLE #EstrategiaTemporal_2002(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2002
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
		FROM  #ProductoComercial PC
		WHERE PC.EstrategiaIdSicc = 2002
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		/* #EstrategiaTemporal_2003 */
		CREATE TABLE #EstrategiaTemporal_2003(
			CodigoOferta	int
			,CampaniaId		int
			,PrecioPublico	decimal(18,2)
			,Ganancia		decimal(18,2)
		)
		INSERT INTO #EstrategiaTemporal_2003
		SELECT
			PC.CodigoOferta
			,PC.CampaniaId
			,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
			,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		FROM (	SELECT CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
				FROM #ProductoComercial
				WHERE EstrategiaIdSicc = 2003
				GROUP BY CampaniaId, CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
		GROUP BY PC.CampaniaId, PC.CodigoOferta
		ORDER BY PC.CampaniaId, PC.CodigoOferta

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN	#EstrategiaTemporal_2001 ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2002 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2002 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET
			 ET.PrecioPublico = ET_GAN.PrecioPublico
			,ET.Ganancia = ET_GAN.Ganancia
		FROM #EstrategiaTemporal ET
		INNER JOIN #ProductoComercial PC
			ON ET.CUV = PC.CUV AND PC.EstrategiaIdSicc = 2003 AND ET.CampaniaId = PC.CampaniaId
		INNER JOIN #EstrategiaTemporal_2003 ET_GAN
			ON PC.CodigoOferta = ET_GAN.CodigoOferta AND PC.CampaniaId = ET_GAN.CampaniaId

		UPDATE ET
		SET ET.Ganancia = 0
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia < 0

		UPDATE ET
		SET ET.PrecioOferta = ET.PrecioPublico
		FROM #EstrategiaTemporal ET
		WHERE ET.PrecioPublico > 0

		UPDATE ET
		SET ET.PrecioTachado = ET.PrecioPublico + ET.Ganancia
		FROM #EstrategiaTemporal ET
		WHERE ET.Ganancia >= 0
	END
	/****FIN - Cálculo de Ganancia****/

	/****INICIO - Cálculo de Niveles****/
	BEGIN
		UPDATE PN
		SET Precio = PN.Nivel * PN.Precio
		FROM #ProductoNivel PN

		CREATE TABLE #ProductoNiveles(
		CUV			varchar(5)
		,CampaniaId	int null
		,Niveles	varchar(200)
		)
		INSERT INTO #ProductoNiveles(
		CUV
		,CampaniaId
		,Niveles)
		SELECT
		PN.CUV,
		PN.CampaniaId,
		Niveles =	(SELECT STUFF(
							(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
							FROM	#ProductoNivel
							WHERE	CUV = PN.CUV and CampaniaId = PN.CampaniaId
							FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
							1,
							1,
							''
						)
					)
		FROM #ProductoNivel PN
		GROUP BY PN.CampaniaId, PN.CUV

		UPDATE ET
		SET
		ET.Niveles = PNS.Niveles
		FROM #EstrategiaTemporal ET
			JOIN #ProductoNiveles PNS
				ON ET.CUV = PNS.CUV and ET.CampaniaId = PNS.CampaniaId
	END
	/****FIN - Limpiando Temporales****/

	/****INICIO - Actualizando precios Estrategia****/
	DECLARE @UserEtl VARCHAR(20)
	DECLARE @Now DATETIME

	SET @UserEtl = 'USER_ETL'
	SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

	UPDATE T
	SET
	T.Precio2			= S.PrecioOferta
	,T.Precio			= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	,T.UsuarioModificacion	= @UserEtl
	,T.FechaModificacion	= @Now
	FROM Estrategia T
		JOIN #EstrategiaTemporal S
			ON T.EstrategiaId = S.EstrategiaTemporalId
	/****FIN - Actualizando EstrategiaTemporal****/

	/****INICIO - Limpiando Temporales****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/****FIN - Limpiando Temporales****/
END
GO

GO
