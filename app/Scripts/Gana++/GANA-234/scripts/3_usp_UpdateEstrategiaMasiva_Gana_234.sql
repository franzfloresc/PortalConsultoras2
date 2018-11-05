USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaMasiva')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaMasiva
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaMasiva
	 @EstrategiaXML AS XML
    ,@TipoEstrategiaID INT
    ,@CampaniaID INT
    ,@UsuarioModificacion VARCHAR(100)
    ,@RetornoActualizacion INT OUT
AS
SET NOCOUNT ON
SET @RetornoActualizacion = 0

--Actualiza columna 'Activo' en la tabla EstrategiaProducto
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

--Actualiza columnas en la tabla Estrategia--
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
        SET  e.DescripcionCUV2 = t.DescripcionCUV2,
             e.LimiteVenta = t.LimiteVenta
            ,e.TextoLibre = t.TextoLibre
            ,e.EsSubCampania = t.EsSubCampania
            ,e.UsuarioModificacion = @UsuarioModificacion
            ,e.FechaModificacion = GETDATE()
            ,e.Activo = t.Activo;

SET @RetornoActualizacion = @@ROWCOUNT
GO

