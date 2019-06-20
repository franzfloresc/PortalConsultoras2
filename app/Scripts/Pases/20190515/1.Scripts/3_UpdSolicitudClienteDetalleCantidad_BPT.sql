USE BelcorpBolivia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpChile
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpDominicana
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpMexico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpPanama
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO

USE BelcorpSalvador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteDetalleCantidad', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteDetalleCantidad
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalleCantidad] 
(
	@SolicitudId BIGINT
	,@Cuv VARCHAR(6)
	,@Cantidad INT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Cantidad = @Cantidad, CantOriginal = CASE WHEN ISNULL(CantOriginal,0) = 0 THEN  Cantidad ELSE CantOriginal END
	WHERE SolicitudClienteID = @SolicitudId
		AND CUV = @Cuv
END
GO
