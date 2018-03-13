
USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.fnObtenerPromedioVentaCampaniaConsecutivas') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnObtenerPromedioVentaCampaniaConsecutivas
END
GO

CREATE FUNCTION [dbo].[fnObtenerPromedioVentaCampaniaConsecutivas]
(
    @CampaniaId VARCHAR(6),
    @CantidadCampaniaConsecutiva INT,
    @ConsultoraId BIGINT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN

    DECLARE @campaniafin VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, 1);
    DECLARE @campaniainicio VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva);

    DECLARE @PromedioVenta DECIMAL(18, 2) = 0;
    DECLARE @TotalPedido DECIMAL(18, 2) = 0;

    SELECT @TotalPedido = SUM(MontoTotalPedido)
    FROM ods.Pedido
    WHERE consultoraid = @ConsultoraId
          AND campaniaid IN (
                                SELECT campaniaid
                                FROM ods.Campania
                                WHERE @campaniainicio <= codigo
                                      AND codigo <= @campaniafin
                            );

    SET @PromedioVenta = @TotalPedido / @CantidadCampaniaConsecutiva;

    RETURN @PromedioVenta;

END;
GO

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.fnObtenerPromedioVentaCampaniaConsecutivas') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnObtenerPromedioVentaCampaniaConsecutivas
END
GO

CREATE FUNCTION [dbo].[fnObtenerPromedioVentaCampaniaConsecutivas]
(
    @CampaniaId VARCHAR(6),
    @CantidadCampaniaConsecutiva INT,
    @ConsultoraId BIGINT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN

    DECLARE @campaniafin VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, 1);
    DECLARE @campaniainicio VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva);

    DECLARE @PromedioVenta DECIMAL(18, 2) = 0;
    DECLARE @TotalPedido DECIMAL(18, 2) = 0;

    SELECT @TotalPedido = SUM(MontoTotalPedido)
    FROM ods.Pedido
    WHERE consultoraid = @ConsultoraId
          AND campaniaid IN (
                                SELECT campaniaid
                                FROM ods.Campania
                                WHERE @campaniainicio <= codigo
                                      AND codigo <= @campaniafin
                            );

    SET @PromedioVenta = @TotalPedido / @CantidadCampaniaConsecutiva;

    RETURN @PromedioVenta;

END;
