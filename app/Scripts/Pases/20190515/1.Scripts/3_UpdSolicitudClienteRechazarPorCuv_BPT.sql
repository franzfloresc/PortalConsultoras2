USE BelcorpBolivia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpChile
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpDominicana
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpMexico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpPanama
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

USE BelcorpSalvador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazarPorCuv', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazarPorCuv
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazarPorCuv] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId
	AND CUV = @Cuv

	DECLARE @cant INT
	SET @cant = (
		SELECT COUNT(CUV) FROM dbo.SolicitudClienteDetalle 
		WHERE SolicitudClienteID = @SolicitudId 
		AND ISNULL(Estado,1) = 1 AND ISNULL(TipoAtencion,0) = 0)

	IF (ISNULL(@cant,0) = 0)
	BEGIN
		UPDATE dbo.SolicitudCliente
		SET Estado = 'R'
		WHERE SolicitudClienteID = @SolicitudId
    END

END
GO

