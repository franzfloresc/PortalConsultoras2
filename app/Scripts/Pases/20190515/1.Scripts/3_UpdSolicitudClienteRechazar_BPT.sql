USE BelcorpBolivia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpChile
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpDominicana
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpMexico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpPanama
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO

USE BelcorpSalvador
GO

IF OBJECT_ID(N'dbo.UpdSolicitudClienteRechazar', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.UpdSolicitudClienteRechazar
END
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteRechazar] 
(
	@SolicitudId BIGINT
)
AS
BEGIN
	UPDATE dbo.SolicitudClienteDetalle
	SET Estado = 0
	WHERE SolicitudClienteID = @SolicitudId

	UPDATE dbo.SolicitudCliente
	SET Estado = 'R'
	WHERE SolicitudClienteID = @SolicitudId

END
GO