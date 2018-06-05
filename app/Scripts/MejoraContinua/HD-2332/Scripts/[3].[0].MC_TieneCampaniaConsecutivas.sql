USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TieneCampaniaConsecutivas]') 
		   AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[TieneCampaniaConsecutivas]
GO

CREATE PROCEDURE [dbo].[TieneCampaniaConsecutivas]
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

    DECLARE @CampaniaFin VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, 1);
    DECLARE @CampaniaInicio VARCHAR(6) = FFVV.fnGetCampaniaAnterior(@CampaniaId, @CantidadCampaniaConsecutiva);

	DECLARE @CantPedidos INT, @CantPedidoWeb INT

	SELECT DISTINCT @CantPedidos = COUNT(CampaniaId) 
	FROM ods.Pedido 
	WHERE ConsultoraId = @ConsultoraId
	AND CampaniaId IN (
		SELECT CampaniaId 
		FROM ods.Campania 
		WHERE Codigo BETWEEN @CampaniaInicio AND @CampaniaFin)

	SELECT @CantPedidoWeb = COUNT(CampaniaId) 
	FROM PedidoWeb 
	WHERE ConsultoraId = @ConsultoraId
	AND CampaniaId BETWEEN @CampaniaInicio AND @CampaniaFin
	AND EstadoPedido = 202

	/*
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
							*/

END;

--IF (@CantidadCampaniaConsecutiva = @NumeroCampaniaPedido)
IF (@CantPedidos >= 3 OR @CantPedidoWeb = @CantidadCampaniaConsecutiva)
    SET @TiemeCampaniaConsecutiva = 1;
ELSE
    SET @TiemeCampaniaConsecutiva = 0;

SELECT @TiemeCampaniaConsecutiva AS TiemeCampaniaConsecutiva;

GO