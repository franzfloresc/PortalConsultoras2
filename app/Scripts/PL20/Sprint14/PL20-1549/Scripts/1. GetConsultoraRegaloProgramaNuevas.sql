
USE BelcorpBolivia
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO

/*end*/

USE BelcorpChile
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpColombia
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpCostaRica
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpDominicana
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpEcuador
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpGuatemala
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpMexico
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpPanama
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpPuertoRico
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpSalvador
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO
/*end*/

USE BelcorpVenezuela
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
	@CUVPremio VARCHAR(6), @DescripcionPremio VARCHAR(100), @CodigoSap VARCHAR(30), 
	@PrecioValorizado DECIMAL(18,2)

SET @Result = 0

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

		IF (ISNULL(@CodigoPrograma,'') <> '')
		BEGIN
			PRINT '2'
			DECLARE @IDX INT

			SELECT TOP 1 @IDX = IDConfiguracionProgramaNuevasUA 
			FROM ods.ConfiguracionProgramaNuevasUA 
			WHERE 
			(CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion AND CodigoZona = @CodigoZona) 
			OR (CodigoPrograma = @CodigoPrograma AND CodigoRegion = @CodigoRegion) 
			OR (CodigoPrograma = @CodigoPrograma) 
			
			IF (ISNULL(@IDX,0) <> 0)
			BEGIN
				PRINT '3'

				SET @CodigoNivel = REPLACE(STR(CAST((@ConsecutivoNueva + 1) AS VARCHAR), 2), SPACE(1), '0')

				SELECT @TippingPoint = MontoVentaExigido 
				FROM ods.ConsultorasProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND Campania = @CampaniaId
				AND CodigoConsultora  = @CodigoConsultora
				AND Participa = 1

				SELECT TOP 1 @CUVPremio = CUV 
				FROM ODS_PE.dbo.PremiosProgramaNuevas 
				WHERE CodigoPrograma = @CodigoPrograma
				AND AnoCampana = @CampaniaId
				AND CodigoNivel = @CodigoNivel

				IF (ISNULL(@CUVPremio,'') != '')
				BEGIN
					PRINT '4'

					SELECT TOP 1 @CodigoSap = CodigoProducto,
						@DescripcionPremio = COALESCE(pc.Descripcion,pd.Descripcion),
						@PrecioValorizado = ISNULL(pc.PrecioValorizado,0)
					FROM ods.ProductoComercial pc 
					LEFT JOIN ProductoDescripcion pd ON pc.AnoCampania = pd.CampaniaID
						AND pc.CUV = pd.CUV
					WHERE pc.AnoCampania = 201709
					AND pc.CUV = @CUVPremio
					AND ISNULL(pc.PrecioCatalogo,0) = 0

					IF (ISNULL(@CodigoSap,'') <> '')
						SET @Result = 1
				END

			END
		END
	END

	IF (@Result = 1)
	BEGIN
		SELECT 
			@CodigoNivel AS CodigoNivel, 
			@TippingPoint AS TippingPoint,
			@CUVPremio AS CUVPremio,
			@DescripcionPremio AS DescripcionPremio,
			@CodigoSap AS CodigoSap,
			@PrecioValorizado AS PrecioValorizado
	END
	
END
GO



