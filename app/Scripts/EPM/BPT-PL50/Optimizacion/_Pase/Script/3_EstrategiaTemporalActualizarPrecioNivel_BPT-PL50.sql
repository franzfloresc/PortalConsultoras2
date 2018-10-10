GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarPrecioNivel') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarPrecioNivel
GO

CREATE PROCEDURE EstrategiaTemporalActualizarPrecioNivel
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN
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
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2001
			AND PC.FactorRepeticion >= 1

	/* #EstrategiaTemporal_2002 */
	CREATE TABLE #EstrategiaTemporal_2002(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2002
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PCD
			ON ET.CUV = PCD.CUV
			AND PCD.EstrategiaIdSicc = 2002
		JOIN #ProductoComercial PC
			ON PCD.CODIGOOFERTA = PC.CODIGOOFERTA
			AND PC.EstrategiaIdSicc = 2002
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PCD.EstrategiaIdSicc
	/* #EstrategiaTemporal_2003 */
	CREATE TABLE #EstrategiaTemporal_2003(
	EstrategiaTemporalId	int
	,PrecioPublico			decimal(18,2)
	,Ganancia				decimal(18,2)
	)
	INSERT INTO #EstrategiaTemporal_2003
	SELECT
	ET.EstrategiaTemporalId
	,PrecioPublico = SUM(PC.PrecioUnitario * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	,Ganancia =  SUM((PC.IndicadorPreUni - PC.PrecioUnitario) * PC.FactorRepeticion * PC.CodigoFactorCuadre)
	FROM #EstrategiaTemporal ET
		JOIN #ProductoComercialDigitable PC
			ON ET.CUV = PC.CUV
			AND PC.EstrategiaIdSicc = 2003
	GROUP BY ET.EstrategiaTemporalId,ET.PrecioOferta,ET.PrecioTachado,PC.EstrategiaIdSicc

	UPDATE ET
	SET
	 ET.PrecioPublico = ET_GAN.PrecioPublico
	,ET.Ganancia = ET_GAN.Ganancia
	FROM #EstrategiaTemporal ET
		JOIN	(
				SELECT * FROM #EstrategiaTemporal_2001
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2002
				UNION ALL
				SELECT * FROM #EstrategiaTemporal_2003
				) ET_GAN
			ON ET.EstrategiaTemporalId = ET_GAN.EstrategiaTemporalId
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
	WHERE ET.Ganancia > 0
	/**** 2. Cálculo de Ganancia - Fin ****/


	/**** 3. Cálculo de Niveles - Ini ****/
	UPDATE PN
	SET Precio = PN.Nivel * PN.Precio
	FROM #ProductoNivel PN

	CREATE TABLE #ProductoNiveles(
	CUV			varchar(5)
	,Niveles	varchar(200)
	)
	INSERT INTO #ProductoNiveles
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
	DROP TABLE #ProductoComercialDigitable
	DROP TABLE #EstrategiaTemporal

	DROP TABLE #EstrategiaTemporal_2001
	DROP TABLE #EstrategiaTemporal_2002
	DROP TABLE #EstrategiaTemporal_2003
	DROP TABLE #ProductoNivel
	DROP TABLE #ProductoNiveles
	/**** 5. Limpiando Temporales - Fin ****/

END
GO

GO
