GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[UpdSolicitudClienteRechazar]
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
