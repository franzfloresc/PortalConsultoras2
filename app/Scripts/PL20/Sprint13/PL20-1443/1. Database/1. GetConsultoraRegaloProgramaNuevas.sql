
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetConsultoraRegaloProgramaNuevas'))
BEGIN
    DROP PROCEDURE dbo.GetConsultoraRegaloProgramaNuevas
END
GO

CREATE PROCEDURE dbo.GetConsultoraRegaloProgramaNuevas
(
	@CampaniaId INT,
	@CodigoConsultora VARCHAR(20),
	@CodigoRegion CHAR(2), 
	@CodigoZona CHAR(4)
)
AS

DECLARE @Result TINYINT, @CodigoNivel CHAR(2), @TippingPoint DECIMAL(18,2),  
	@CUVPremio VARCHAR(6), @CodigoSap VARCHAR(30)

SET @Result = 0
SET @CampaniaId = 201707
SET @CodigoConsultora = '033076916'
SET @CodigoRegion = '10'
SET @CodigoZona = '1083'

BEGIN 
	DECLARE @IdEstadoActividad INT, @ConsecutivoNueva INT

	SELECT 
		@IdEstadoActividad = IdEstadoActividad, 
		@ConsecutivoNueva = ConsecutivoNueva
	FROM ods.Consultora WHERE Codigo = @CodigoConsultora

	IF (@IdEstadoActividad IN (1,7))
	BEGIN
		PRINT '1'
		DECLARE @CodigoPrograma VARCHAR(4)

		SELECT @CodigoPrograma = ISNULL(CodigoPrograma,'') 
		FROM ods.ConfiguracionProgramaNuevas 
		WHERE CampaniaInicio <= @CampaniaId AND CampaniaFin >= @CampaniaId
		AND IndExigVent = 1

		IF (ISNULL(@CodigoPrograma,'') != '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = '036')

			IF (ISNULL(@IDX,0) != 0)
			BEGIN
				PRINT '3'
				--DECLARE @MontoVentaExigido DECIMAL(18,2), @CodigoNivel CHAR(2)

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				--DECLARE @CUVPremio VARCHAR(6)
				SET @Result = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					SELECT TOP 1 @CodigoSap = CodigoProducto
					FROM ods.ProductoComercial 
					WHERE AnoCampania = 201707 AND CUV = @CUVPremio
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			--@CodigoNivel AS CodigoNivel, 
			'04' AS CodigoNivel,
			@TippingPoint AS TippingPoint, @CUVPremio AS CUVPremio, 
			/*@CodigoSap AS CodigoSap*/
			'200063718' AS CodigoSap
	END
	
END