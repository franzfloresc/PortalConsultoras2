
USE [BelcorpColombia]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpCostaRica]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpDominicana]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpEcuador]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpGuatemala]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpMexico]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpPanama]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpPeru]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go

USE [BelcorpSalvador]
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleValAuto]  
 @CampaniaID INT,  
 @PedidoID INT,  
 @PedidoDetalleID SMALLINT,
 @ConsultoraID bigint,
 @MarcaID int,
 @CUV varchar(20),
 @Cantidad int,
 @PrecioUnidad money,
 @FechaCreacion datetime
AS  

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

DELETE FROM dbo.PedidoWebDetalle  
WHERE CampaniaID = @CampaniaID AND  
	  PedidoID = @PedidoID AND  
	  PedidoDetalleID = @PedidoDetalleID
  
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
	ItemValidado)
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
	0
)
go


