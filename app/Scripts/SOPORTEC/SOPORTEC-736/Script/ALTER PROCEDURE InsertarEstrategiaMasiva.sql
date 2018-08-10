USE BelcorpPeru
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpMexico
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpColombia
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpSalvador
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpPuertoRico
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpPanama
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpGuatemala
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpEcuador
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpDominicana
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpCostaRica
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpChile
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
USE BelcorpBolivia
GO
IF (OBJECT_ID('dbo.InsertarEstrategiaMasiva', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategiaMasiva AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva @EstrategiaXML AS XML
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@RetornoActualizacion INT OUT
	,@RetornoInsercion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0
SET @RetornoInsercion = 0

MERGE INTO dbo.EstrategiaProducto ep
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON ep.Campania = @CampaniaID
		AND ep.CUV2 = t.CUV2
		AND t.Activo = 1
WHEN MATCHED
	THEN
		UPDATE
		SET ep.Activo = 1;

---*---
MERGE INTO dbo.Estrategia e
USING (
	SELECT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
		,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
		,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
		,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
		,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
		,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
	) t
	ON e.TipoEstrategiaID = @TipoEstrategiaID
		AND e.CampaniaId = @CampaniaID
		AND e.CUV2 = t.CUV2
WHEN MATCHED
	THEN
		UPDATE
		SET e.DescripcionCUV2 = t.DescripcionCUV2,
			e.LimiteVenta = t.LimiteVenta
			,e.TextoLibre = t.TextoLibre
			,e.EsSubCampania = t.EsSubCampania
			,e.UsuarioModificacion = @UsuarioModificacion
			,e.FechaModificacion = GETDATE()
			,

			e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT

---*---
INSERT INTO dbo.Estrategia (
	CUV2
	,DescripcionCUV2
	,
	LimiteVenta
	,TextoLibre
	,EsSubCampania
	,UsuarioCreacion
	,FechaCreacion
	,TipoEstrategiaID
	,CampaniaID
	,EtiquetaID
	,EtiquetaID2
	,Activo
	,CampaniaIDFin
	,NumeroPedido
	,FlagDescripcion
	,CUV
	,FlagCEP
	,FlagCEP2
	,Cantidad
	,FlagCantidad
	,ColorFondo
	)
SELECT DISTINCT tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
	,tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
	,tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
	,tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
	,tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
	,@UsuarioCreacion AS 'UsuarioCreacion'
	,GETDATE() AS 'FechaCreacion'
	,@TipoEstrategiaID AS 'TipoEstrategiaID'
	,@CampaniaID AS 'CampaniaID'
	,0 AS 'EtiquetaID'
	,0 AS 'EtiquetaID2'
	,tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
	,0 AS 'CampaniaIDFin'
	,0 AS 'NumeroPedido'
	,1 AS 'FlagDescripcion'
	,'' AS 'CUV'
	,0 AS 'FlagCEP'
	,1 AS 'FlagCEP2'
	,NULL AS 'Cantidad'
	,0 AS 'FlagCantidad'
	,'' AS 'ColorFondo'
FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
INNER JOIN ods.OfertasPersonalizadasCUV op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
	AND op.AnioCampanaVenta = @CampaniaID
	AND op.TipoPersonalizacion = 'SR'
WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (
		SELECT CUV2
		FROM dbo.Estrategia e
		WHERE e.TipoEstrategiaID = @TipoEstrategiaID
			AND e.CampaniaId = @CampaniaID
		)

SET @RetornoInsercion = @@ROWCOUNT

GO
