
USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'TieneCampaniaConsecutivas')
BEGIN
    DROP PROCEDURE dbo.TieneCampaniaConsecutivas
END
GO

CREATE PROCEDURE dbo.TieneCampaniaConsecutivas
    @CampaniaId VARCHAR(6),
    @CantidadCampaniaConsecutiva INT,
    @ConsultoraId BIGINT
AS
/*
TieneCampaniaConsecutivas '201716',3,351
TieneCampaniaConsecutivas '201717',3,351
*/
BEGIN

    DECLARE @TiemeCampaniaConsecutiva BIT = 0;

    DECLARE @campaniafin VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, 1);
    DECLARE @campaniainicio VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva);

    DECLARE @NumeroCampaniaPedido INT = 0;
    SELECT @NumeroCampaniaPedido = COUNT(*)
    FROM ods.Pedido
    WHERE consultoraid = @ConsultoraId
          AND campaniaid IN (
                                SELECT campaniaid
                                FROM ods.Campania
                                WHERE @campaniainicio <= codigo
                                      AND codigo <= @campaniafin
                            );

END;

IF (@CantidadCampaniaConsecutiva = @NumeroCampaniaPedido)
    SET @TiemeCampaniaConsecutiva = 1;
ELSE
    SET @TiemeCampaniaConsecutiva = 0;

SELECT @TiemeCampaniaConsecutiva AS TiemeCampaniaConsecutiva;

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'TieneCampaniaConsecutivas')
BEGIN
    DROP PROCEDURE dbo.TieneCampaniaConsecutivas
END
GO

CREATE PROCEDURE dbo.TieneCampaniaConsecutivas
    @CampaniaId VARCHAR(6),
    @CantidadCampaniaConsecutiva INT,
    @ConsultoraId BIGINT
AS
/*
TieneCampaniaConsecutivas '201716',3,351
TieneCampaniaConsecutivas '201717',3,351
*/
BEGIN

    DECLARE @TiemeCampaniaConsecutiva BIT = 0;

    DECLARE @campaniafin VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, 1);
    DECLARE @campaniainicio VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva);

    DECLARE @NumeroCampaniaPedido INT = 0;
    SELECT @NumeroCampaniaPedido = COUNT(*)
    FROM ods.Pedido
    WHERE consultoraid = @ConsultoraId
          AND campaniaid IN (
                                SELECT campaniaid
                                FROM ods.Campania
                                WHERE @campaniainicio <= codigo
                                      AND codigo <= @campaniafin
                            );

END;

IF (@CantidadCampaniaConsecutiva = @NumeroCampaniaPedido)
    SET @TiemeCampaniaConsecutiva = 1;
ELSE
    SET @TiemeCampaniaConsecutiva = 0;

SELECT @TiemeCampaniaConsecutiva AS TiemeCampaniaConsecutiva;

GO