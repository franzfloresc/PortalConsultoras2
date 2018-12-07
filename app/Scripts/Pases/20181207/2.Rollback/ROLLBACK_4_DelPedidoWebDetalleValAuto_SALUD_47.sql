
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
	0
)


GO


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
	0
)


GO


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
	0
)


GO


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
	0
)


GO


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
	0
)


GO



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
	0
)


GO

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
	0
)


GO


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
	0
)


GO


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
	0
)


GO

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
	0
)


GO


