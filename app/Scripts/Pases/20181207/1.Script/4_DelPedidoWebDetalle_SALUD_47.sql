
USE [BelcorpBolivia]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpChile]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpColombia]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpCostaRica]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpDominicana]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpEcuador]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpGuatemala]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpMexico]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpPanama]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpPeru]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go


USE [BelcorpSalvador]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalle]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @MensajeErrorPROL VARCHAR(200) = null
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DECLARE @MarcaID int, @ConsultoraID bigint, @CUV varchar(20), @Cantidad int, @PrecioUnidad money, @FechaCreacion datetime, @ItemValidado bit;
DECLARE @PedidoWebAccionesPROLID bigint

SELECT	@MarcaID = MarcaID,
		@ConsultoraID = ConsultoraID,
		@CUV = CUV,
		@Cantidad = Cantidad,
		@PrecioUnidad = PrecioUnidad,
		@FechaCreacion = FechaCreacion,
		@ItemValidado = ModificaPedidoReservado
FROM	dbo.PedidoWebDetalle 
WHERE	CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		PedidoDetalleID = @PedidoDetalleID

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID

/*consultora online*/
IF (EXISTS(SELECT 1 FROM dbo.SolicitudClienteDetalle WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID))
begin
	UPDATE dbo.SolicitudClienteDetalle 
	SET PedidoWebID = 0, PedidoWebDetalleID = 0 
	WHERE PedidoWebID = @PedidoID AND PedidoWebDetalleID = @PedidoDetalleID
	
	DECLARE @restan INT

	SET @restan = (
		SELECT ISNULL(count(PedidoWebID),0) FROM SolicitudClienteDetalle 
		WHERE PedidoWebID = @PedidoID AND ISNULL(PedidoWebDetalleID,0) <> 0)

	IF (@restan = 0)
	BEGIN
		UPDATE SolicitudCliente SET PedidoWebID = 0 WHERE PedidoWebID = @PedidoID
	END
END

--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL(
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ConsultoraID,
		CUV,
		Cantidad,
		PrecioUnidad,
		Tipo,
		Accion,
		FechaAccion,
		MensajePROL,
		ValAutomaticaPROLLogId,
		CodigoObservacion,
		TipoOrigen
	)
	VALUES
	(
		@CampaniaID,
		@PedidoID,
		@PedidoDetalleID,
		@ConsultoraID,
		@CUV,
		@Cantidad,
		@PrecioUnidad,
		100,
		101,
		@FechaGeneral,
		@MensajeErrorPROL,
		NULL,
		NULL,
		NULL
	)

	SET @PedidoWebAccionesPROLID = SCOPE_IDENTITY()	
END

/*consultora online*/
INSERT INTO PedidoWebDetalleSeguimiento(
	PedidoID,
	MarcaID,
	ConsultoraID,
	CampaniaID,
	CUV,
	AccionId,
	FechaAccion,
	Cantidad,
	PrecioUnidad,
	FechaCreacion,
	ItemValidado,
	PedidoWebAccionesPROLID)
VALUES
(
	@PedidoID,
	@MarcaID,
	@ConsultoraID,
	@CampaniaID,
	@CUV,
	401,
	@FechaGeneral,
	@Cantidad,
	@PrecioUnidad,
	@FechaCreacion,
	@ItemValidado,
	@PedidoWebAccionesPROLID
)

go

