USE BelcorpPeru
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

INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

/*end*/

USE BelcorpColombia
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END


/*end*/

USE BelcorpChile
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
 
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

/*end*/

USE BelcorpMexico
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

INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

/*end*/

USE BelcorpEcuador
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

INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END


/*end*/

USE BelcorpCostaRica
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END


/*end*/


USE BelcorpBolivia
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

/*end*/

USE BelcorpDominicana
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END


/*end*/

USE BelcorpGuatemala
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

/*end*/

USE BelcorpPanama
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END



/*end*/

USE BelcorpPuertoRico
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END



/*end*/

USE BelcorpSalvador
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END


/*end*/

USE BelcorpVenezuela
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
  
INSERT INTO PedidoWebDetalleSeguimiento
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
	@ItemValidado
)
--Tipo 100: Manual
--Tipo 101: Eliminar CUV con observación PROL
IF ISNULL(@MensajeErrorPROL,'') <> ''
BEGIN

	INSERT INTO PedidoWebAccionesPROL
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
END

