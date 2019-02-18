GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN

	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN
		DECLARE @UserEtl VARCHAR(20)
		DECLARE @Now DATETIME

		SET @UserEtl = 'USER_ETL'
		SELECT @Now = [dbo].[fnObtenerFechaHoraPais] ()

		--Actualizando la tabla EstrategiaProducto
		CREATE TABLE #TEMPORAL (
			[EstrategiaProductoId] [int] NOT NULL,
			[EstrategiaId] [int] NOT NULL,
			[Campania] [int] NOT NULL,
			[CUV] [nvarchar](20) NOT NULL,
			[CodigoEstrategia] [nvarchar](100) NOT NULL,
			[Grupo] [nvarchar](20) NULL,
			[Orden] [int] NULL,
			[CUV2] [nvarchar](20) NULL,
			[SAP] [nvarchar](50) NULL,
			[Cantidad] [int] NULL,
			[Precio] [money] NULL,
			[PrecioValorizado] [money] NULL,
			[Digitable] [int] NULL,
			[CodigoError] [nvarchar](100) NULL,
			[CodigoErrorObs] [nvarchar](4000) NULL,
			[FactorCuadre] [int] NULL,
			[IdMarca] [int] NULL,
			[NombreProducto] [nvarchar](150) NULL
		)

		INSERT INTO #TEMPORAL
		SELECT
			1,
			e.EstrategiaID,
			ept.Campania,
			ept.Cuv,
			ept.CodigoEstrategia,
			ept.Grupo,
			ept.Orden,
			ept.CuvPadre,
			ept.CodigoSap,
			ept.Cantidad,
			ept.PrecioUnitario,
			ept.PrecioUnitario,
			ept.Digitable,
			'',
			'',
			ept.FactorCuadre,
			ept.IdMarca,
			ept.Descripcion
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId)
		WHEN MATCHED AND (T.Digitable <> S.Digitable OR T.Orden <> S.Orden OR T.Cantidad <> S.Cantidad
			OR T.FactorCuadre <> S.FactorCuadre OR T.Grupo <> S.Grupo OR T.CodigoEstrategia <> S.CodigoEstrategia ) THEN
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden, T.IdMarca = S.IdMarca, T.Cantidad = S.Cantidad,
			T.FactorCuadre = S.FactorCuadre, T.Grupo = S.Grupo, T.CodigoEstrategia = S.CodigoEstrategia,
			T.UsuarioModificacion = @UserEtl, T.FechaModificacion = @Now
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (EstrategiaId
				,Campania
				,CUV
				,CodigoEstrategia
				,Grupo
				,Orden
				,CUV2
				,SAP
				,Cantidad
				,Precio
				,PrecioValorizado
				,Digitable
				,CodigoError
				,CodigoErrorObs
				,FactorCuadre
				,IdMarca
				,NombreProducto
				,UsuarioCreacion
				,FechaCreacion)
		VALUES (S.EstrategiaId
				,S.Campania
				,S.CUV
				,S.CodigoEstrategia
				,S.Grupo
				,S.Orden
				,S.CUV2
				,S.SAP
				,S.Cantidad
				,S.Precio
				,S.PrecioValorizado
				,S.Digitable
				,S.CodigoError
				,S.CodigoErrorObs
				,S.FactorCuadre
				,S.IdMarca
				,S.NombreProducto
				,@UserEtl
				,@Now)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN
		DELETE;

		-- ELIMINA CUVS DUPLICADOS DE LA TABLA ESTRATEGIAPRODUCTO --
		DELETE FROM estrategiaproducto WHERE EstrategiaProductoId IN (
		SELECT MIN(E.EstrategiaProductoId) FROM estrategiaproducto E

	INNER JOIN (SELECT EP.EstrategiaId, CUV FROM EstrategiaProducto EP
			WHERE EP.EstrategiaId IN (SELECT EstrategiaId FROM #TEMPORAL)
			GROUP BY EP.Campania, EP.EstrategiaId, EP.CUV
			HAVING COUNT(EP.CUV) > 1 ) T ON T.EstrategiaId = E.EstrategiaId AND T.CUV = E.CUV
		GROUP BY E.Campania, E.EstrategiaId, E.CUV)

		-- Actualizar la tabla estrategia en base a la actualizacion de EstrategiaProductos
		UPDATE Estrategia SET
			CodigoEstrategia = NULL,
			TieneVariedad = NULL
		WHERE CampaniaID IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)

		UPDATE Estrategia SET
			CodigoEstrategia = P.CodigoEstrategia,
			TieneVariedad = P.Variedad
		FROM (SELECT EstrategiaId,
					MAX(CodigoEstrategia) CodigoEstrategia,
					CASE MAX(CodigoEstrategia)
					WHEN '2003' THEN 1
					WHEN '2002' THEN 0
					WHEN '2001' THEN 0
					ELSE 0 END AS Variedad
			FROM EstrategiaProducto
			WHERE Campania IN (SELECT Campania FROM EstrategiaProductoTemporal GROUP BY Campania)
			GROUP BY EstrategiaId) P
		WHERE Estrategia.EstrategiaID = P.EstrategiaId

		-- Eliminar tablas temporales
		DROP TABLE #TEMPORAL
	END
END
GO

GO
