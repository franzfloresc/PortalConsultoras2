GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE dbo.InsertarEstrategiaMasiva
@EstrategiaXML as XML,
@TipoEstrategiaID INT,
@CampaniaID INT,
@UsuarioCreacion VARCHAR(100),
@UsuarioModificacion VARCHAR(100),
@RetornoActualizacion INT OUT,
@RetornoInsercion INT OUT
AS
 SET NOCOUNT ON
 SET @RetornoActualizacion = 0
 SET @RetornoInsercion = 0
---*---
MERGE INTO dbo.Estrategia e
   USING (SELECT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)) t
   ON  e.TipoEstrategiaID = @TipoEstrategiaID
   AND e.CampaniaId = @CampaniaID
   AND e.CUV2 = t.CUV2
WHEN MATCHED THEN
   UPDATE
      SET e.DescripcionCUV2 = t.DescripcionCUV2,
       e.Precio = t.Precio,
    e.Precio2 = t.Precio2,
    e.LimiteVenta = t.LimiteVenta,
    e.TextoLibre = t.TextoLibre,
    e.EsSubCampania = t.EsSubCampania,
    e.UsuarioModificacion =  @UsuarioModificacion,
    e.FechaModificacion = GETDATE(),
    e.Ganancia =ISNULL(t.Precio,0) - ISNULL(t.Precio2,0),
    e.Activo = t.Activo;
 SET @RetornoActualizacion = @@ROWCOUNT
---*---
INSERT INTO dbo.Estrategia (CUV2, DescripcionCUV2, Precio, Precio2, LimiteVenta, TextoLibre, EsSubCampania, UsuarioCreacion, FechaCreacion, TipoEstrategiaID, CampaniaID, EtiquetaID,EtiquetaID2, Activo, CampaniaIDFin, NumeroPedido, FlagDescripcion, CUV, Fl
agCEP, FlagCEP2, Cantidad, FlagCantidad, ColorFondo, Ganancia)
SELECT DISTINCT  tabla.variable.value('CUV2[1]', 'VARCHAR(20)') AS 'CUV2'
      , tabla.variable.value('DescripcionCUV2[1]', 'VARCHAR(800)') AS 'DescripcionCUV2'
    , tabla.variable.value('Precio[1]', 'NUMERIC(12,2)') AS 'Precio'
    , tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)') AS 'Precio2'
    , tabla.variable.value('LimiteVenta[1]', 'INT') AS 'LimiteVenta'
    , tabla.variable.value('TextoLibre[1]', 'VARCHAR(800)') AS 'TextoLibre'
    , tabla.variable.value('EsSubCampania[1]', 'BIT') AS 'EsSubCampania'
    , @UsuarioCreacion AS 'UsuarioCreacion'
    , GETDATE() AS 'FechaCreacion'
    , @TipoEstrategiaID AS 'TipoEstrategiaID'
    , @CampaniaID AS 'CampaniaID'
    , 0 AS 'EtiquetaID'
    , 0 AS 'EtiquetaID2'
    , tabla.variable.value('Activo[1]', 'BIT') AS 'Activo'
    , 0 AS 'CampaniaIDFin'
    , 0 AS 'NumeroPedido'
    , 1 AS 'FlagDescripcion'
    , '' AS 'CUV'
    , 0 AS 'FlagCEP'
    , 1 AS 'FlagCEP2'
    , null AS 'Cantidad'
    , 0 AS 'FlagCantidad'
    , '' AS 'ColorFondo'
    ,ISNULL(tabla.variable.value('Precio[1]', 'NUMERIC(12,2)'),0) -  ISNULL(tabla.variable.value('Precio2[1]', 'NUMERIC(12,2)'),0) AS 'Ganancia'
 FROM @EstrategiaXML.nodes('/strategy/row') tabla(variable)
 INNER JOIN ods.OfertasPersonalizadas op ON op.CUV = tabla.variable.value('CUV2[1]', 'VARCHAR(20)')
 AND op.AnioCampanaVenta = @CampaniaID and op.TipoPersonalizacion = 'SR'
  WHERE tabla.variable.value('CUV2[1]', 'VARCHAR(20)') NOT IN (SELECT CUV2
                  FROM dbo.Estrategia e
                  WHERE e.TipoEstrategiaID = @TipoEstrategiaID
                  AND e.CampaniaId = @CampaniaID)
 SET @RetornoInsercion = @@ROWCOUNT

GO

GO
