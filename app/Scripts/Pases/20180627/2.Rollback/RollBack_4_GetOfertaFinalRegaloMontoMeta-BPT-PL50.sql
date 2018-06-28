GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE [dbo].[GetOfertaFinalRegaloMontoMeta]
(
    @CampaniaId INT,
    @ConsultoraId INT
)
AS
BEGIN

	DECLARE @MontoTotal MONEY
	SELECT @MontoTotal = ISNULL(ImporteTotal,0)
	FROM PedidoWeb
	WHERE CampaniaId = @CampaniaId
	AND ConsultoraId = @ConsultoraId
	IF @MontoTotal = 0
		RETURN;

    DECLARE @RangoId INT,
            @GapAgregar DECIMAL(18, 2),
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
			@MontoMeta DECIMAL(18,2)
    SET @MontoMeta = 0;
    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
          AND Algoritmo = 'OFR';

    IF (@RangoId != 0)
    BEGIN
        DECLARE @CodigoConsultora VARCHAR(20),
                @MontoMaxPedido DECIMAL(18, 2)
                --@ConsecutivoNueva INT,
                --@RestaKitNuevas DECIMAL(18, 2);
        --SET @RestaKitNuevas = 0;
        SELECT @CodigoConsultora = Codigo,
               @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
               --@ConsecutivoNueva = ISNULL(ConsecutivoNueva, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;
        /*MontoMeta por Objectivo */
        DECLARE @MontoMetaPromedio DECIMAL(18, 2) = 0;
        DECLARE @TipoRangoPromedio VARCHAR(3) = '';
        SELECT @MontoMetaPromedio = MontoMeta,
               @TipoRangoPromedio = TipoRango
        FROM OfertaFinalMontoObjetivo
        WHERE CodigoConsultora = @CodigoConsultora;

        IF (@MontoMeta < @MontoMetaPromedio)
        BEGIN
            SET @MontoMeta = @MontoMetaPromedio;
            SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
                   @GapAgregar = ISNULL(PrecioMinimo, 0),
                   @GapMinimo = ISNULL(GapMinimo, 0),
                   @GapMaximo = ISNULL(GapMaximo, 0),
                   @TipoRango = Tipo
            FROM dbo.OfertaFinalParametria
            WHERE Tipo = @TipoRangoPromedio
                  AND Algoritmo = 'OFR';
        END;
    END;
	SELECT
		@RangoId AS RangoId,
		@GapMinimo AS GapMinimo,
		@GapMaximo AS GapMaximo,
		@GapAgregar AS GapAgregar,
		@TipoRango AS TipoRango,
		@MontoMeta AS MontoMeta
END;
GO

GO
