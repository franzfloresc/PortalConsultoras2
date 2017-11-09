
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO


USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsertarOfertaFinalRegaloSorpresa]
(
    @CampaniaID INT,
    @ConsultoraId INT,
    @MontoTotal MONEY,
    @Algoritmo VARCHAR(10),
    @MontoMeta DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    /*Precondicion: MontoTotal > MontoMinimo en OfertaFinal*/
    IF @Algoritmo != 'OFR'
        RETURN;

    DECLARE @GapAgregar DECIMAL(18, 2), --@MontoMeta decimal(18,2),
            @RangoId INT,
            @GapMinimo DECIMAL(18, 2),
            @GapMaximo DECIMAL(18, 2),
            @TipoRango VARCHAR(3),
            @MontoMaxPedido DECIMAL(18, 2);

    SET @MontoMeta = 0;

    SELECT @RangoId = ISNULL(OfertaFinalParametriaID, 0),
           @GapAgregar = ISNULL(PrecioMinimo, 0),
           @GapMinimo = ISNULL(GapMinimo, 0),
           @GapMaximo = ISNULL(GapMaximo, 0),
           @TipoRango = Tipo
    FROM dbo.OfertaFinalParametria
    WHERE Tipo LIKE 'RG%'
          AND @MontoTotal >= GapMinimo
          AND @MontoTotal <= GapMaximo
          AND Algoritmo = @Algoritmo;

    IF (@RangoId != 0)
    BEGIN
        SELECT @MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
        FROM ods.Consultora
        WHERE ConsultoraId = @ConsultoraId;

        SET @MontoMeta = @MontoTotal + @GapAgregar;

        IF (@MontoMeta <= @MontoMaxPedido)
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM OfertaFinalMontoMeta WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND ConsultoraId = @ConsultoraId
            )
            BEGIN
                /*Monto Meta y Regalo*/
                DECLARE @Cuv VARCHAR(100);

                SELECT @Cuv = Cuv
                FROM OfertaFinalRegaloXCampania WITH (NOLOCK)
                WHERE CampaniaId = @CampaniaID
                      AND RangoId = @RangoId;

                --Set @MontoMeta = @MontoTotal + Convert(decimal(18,2),@GapAgregar*(@MontoTotal))/100
                --SET @MontoMeta = @MontoTotal + @GapAgregar;
                INSERT INTO OfertaFinalMontoMeta
                (
                    CampaniaId,
                    ConsultoraId,
                    MontoPedido,
                    GapMinimo,
                    GapMaximo,
                    GapAgregar,
                    MontoMeta,
                    Cuv,
                    TipoRango,
                    FechaRegistro
                )
                SELECT CampaniaId = @CampaniaID,
                       ConsultoraId = @ConsultoraId,
                       MontoPedido = @MontoTotal,
                       GapMinimo = @GapMinimo,
                       GapMaximo = @GapMaximo,
                       GapAgregar = @GapAgregar,
                       MontoMeta = @MontoMeta,
                       Cuv = @Cuv,
                       TipoRango = @TipoRango,
                       FechaRegistro = GETDATE();
            END;

        END;
        ELSE
            SET @MontoMeta = 0;
    END;
    ELSE
        SET @MontoMeta = 0;

END;

GO