USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as
BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as
BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as
BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudIdId

END

/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as
BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudIdd

END

/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as
BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END


/*end*/


USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END

/*end*/

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[UpdSolicitudClienteDetalle_SB2]
(
	@SolicitudDetalleId BIGINT,
	@TipoAtencion INT,
	@PedidoWebID INT,
	@PedidoWebDetalleID INT
)
as

BEGIN

DECLARE @SolicitudId INT

UPDATE SolicitudClienteDetalle SET TipoAtencion = @TipoAtencion, 
PedidoWebID = @PedidoWebID, 
PedidoWebDetalleID = @PedidoWebDetalleID 
WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

SELECT @SolicitudId = SolicitudClienteID FROM SolicitudClienteDetalle WHERE SolicitudClienteDetalleID = @SolicitudDetalleId

UPDATE SolicitudCliente set PedidoWebID = @PedidoWebID WHERE SolicitudClienteID = @SolicitudId

END



