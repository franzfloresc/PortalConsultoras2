USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizarTonosEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ActualizarTonosEstrategia]
GO

CREATE PROCEDURE [dbo].[ActualizarTonosEstrategia]
AS
BEGIN
	
	DECLARE @RegistrosTemporales INT
	SELECT @RegistrosTemporales = COUNT(*) FROM EstrategiaProductoTemporal

	IF(@RegistrosTemporales > 1)
	BEGIN 
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
			[FactorCuadre] [int] NULL
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
			ept.FactorCuadre
		FROM Estrategia e
		INNER JOIN EstrategiaProductoTemporal ept ON e.CampaniaID = ept.Campania AND e.CUV2 = ept.CuvPadre

		MERGE EstrategiaProducto AS T
		USING #TEMPORAL AS S
		ON (T.CUV = S.CUV AND T.Campania = S.Campania AND T.EstrategiaId = S.EstrategiaId) 
		WHEN MATCHED AND T.Digitable <> S.Digitable OR T.Orden <> S.Orden THEN 
		UPDATE SET T.Digitable = S.Digitable, T.Orden = S.Orden 
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
				,FactorCuadre) 
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
				,S.FactorCuadre)
		WHEN NOT MATCHED BY SOURCE AND T.Campania IN (SELECT Campania FROM #TEMPORAL GROUP BY Campania) THEN 
		DELETE;

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
					WHEN '2001' THEN (CASE WHEN COUNT(CodigoEstrategia) > 1 THEN 1 ELSE 0 END)
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




