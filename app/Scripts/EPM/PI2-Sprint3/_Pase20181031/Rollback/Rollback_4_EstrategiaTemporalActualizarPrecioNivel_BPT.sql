GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE [dbo].[EstrategiaTemporalActualizarPrecioNivel]
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	/**** 1. Creando Temporales - Ini ****/
	--DECLARE @NroLote INT = 91
	DECLARE @CampaniaId INT = 0
	/* #EstrategiaTemporal */
	CREATE TABLE #EstrategiaTemporal(
		EstrategiaTemporalId	int
		,CampaniaId				int
		,CUV					varchar(5)
		,PrecioOferta			decimal(18,2)
		,PrecioTachado			decimal(18,2)
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
		,Niveles				varchar(200)
	)
	INSERT INTO #EstrategiaTemporal
	SELECT
		EstrategiaTemporalId
		,CampaniaId
		,CUV
		,PrecioOferta
		,PrecioTachado
		,PrecioPublico
		,Ganancia
		,Niveles
	FROM EstrategiaTemporal ET
	WHERE
	ET.NumeroLote = @NroLote
	and ET.Pagina = @Pagina

	/* @CampaniaId */
	SELECT TOP 1 @CampaniaId = CampaniaId
	FROM #EstrategiaTemporal
	/* #ProductoComercial*/
	CREATE TABLE #ProductoComercial(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercial
	SELECT
		PC.CampaniaID
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
	WHERE PC.AnoCampania = @CampaniaId

	/* #ProductoComercialDigitable */
	CREATE TABLE #ProductoComercialDigitable(
		CampaniaID			int
		,CUV				varchar(50)
		,PrecioUnitario		numeric(12,2)
		,FactorRepeticion	int
		,IndicadorDigitable	bit
		,AnoCampania		int
		,IndicadorPreUni	numeric(12,2)
		,CodigoFactorCuadre	numeric(12,2)
		,EstrategiaIdSicc	int
		,CodigoOferta		int
		,NumeroGrupo		int
		,NumeroNivel		int
	)
	INSERT INTO #ProductoComercialDigitable
	SELECT
		PC.CampaniaID
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
	FROM #ProductoComercial PC
	WHERE PC.AnoCampania = @CampaniaId
	AND pc.IndicadorDigitable =  1
	/* #ProductoNivel */
	CREATE TABLE #ProductoNivel(
		CUV			varchar(5)
		,Nivel		int
		,Precio		numeric(12,2)
	)
	INSERT INTO #ProductoNivel
	SELECT
		ET.CUV
		,Nivel = PN.FactorCuadre
		,Precio = PN.PrecioUnitario
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
		JOIN ODS.ProductoNivel PN
			ON PCD.NumeroNivel = PN.NumeroNivel
			AND PN.Campana = @CampaniaId
			AND PN.FactorCuadre > 1
	GROUP BY
	ET.CUV
	,PN.FactorCuadre
	,PN.PrecioUnitario
	/**** 1. Creando Temporales - Fin ****/


	/**** 2. Cálculo de Ganancia - Ini ****/
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
		ON ET.CUV = PC.CUV
		AND (PC.EstrategiaIdSicc = 2001 OR PC.EstrategiaIdSicc IS NULL)
		AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM  #ProductoComercial PC
	WHERE PC.EstrategiaIdSicc = 2002
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
		CodigoOferta	int
		,PrecioPublico			decimal(18,2)
		,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
		PC.CODIGOOFERTA
		,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
		,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM (
			SELECT CodigoOferta, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre
			FROM #ProductoComercial
			WHERE EstrategiaIdSicc = 2003
			GROUP BY CODIGOOFERTA, NumeroGrupo, PrecioUnitario, IndicadorPreUni,  FactorRepeticion, CodigoFactorCuadre) PC
	GROUP BY PC.CODIGOOFERTA
	ORDER BY PC.CODIGOOFERTA

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
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2002
	INNER JOIN #EstrategiaTemporal_2002 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

	UPDATE ET
	SET
		 ET.PrecioPublico = ET_GAN.PrecioPublico
		,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
	INNER JOIN #ProductoComercial PC ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	INNER JOIN #EstrategiaTemporal_2003 ET_GAN
		ON PC.CodigoOferta = ET_GAN.CodigoOferta

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
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles (
	CUV
	,Niveles)
	SELECT
	PN.CUV,
	Niveles =	(	SELECT STUFF(	(SELECT	'|' + CONVERT(varchar, Nivel)  + 'X' + '-' + CONVERT(varchar, Precio)
									FROM	#ProductoNivel
									WHERE	CUV = PN.CUV
									FOR XML PATH(''), TYPE).value('.[1]', 'varchar(200)'),
									1,
									1,
									''
								)
				)
	FROM #ProductoNivel PN
	GROUP BY PN.CUV
	UPDATE ET
	SET
	ET.Niveles = PNS.Niveles
	FROM #EstrategiaTemporal ET
		JOIN #ProductoNiveles PNS
			ON ET.CUV = PNS.CUV
	/**** 3. Limpiando Temporales - Fin ****/


	/**** 4. Actualizando EstrategiaTemporal - Ini ****/
	UPDATE T
	SET
	T.PrecioOferta			= S.PrecioOferta
	,T.PrecioTachado		= S.PrecioTachado
	,T.PrecioPublico		= S.PrecioPublico
	,T.Ganancia				= S.Ganancia
	,T.Niveles				= S.Niveles
	FROM EstrategiaTemporal T
		join #EstrategiaTemporal S
			on T.EstrategiaTemporalId = S.EstrategiaTemporalId
	/**** 4. Actualizando EstrategiaTemporal - Fin ****/


	/**** 5. Limpiando Temporales - Ini ****/
	DROP TABLE #ProductoComercial
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles

	SET QUOTED_IDENTIFIER OFF
	SET ANSI_NULLS OFF
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
