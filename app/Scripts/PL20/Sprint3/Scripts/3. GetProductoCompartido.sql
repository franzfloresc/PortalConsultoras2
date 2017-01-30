
USE [BelcorpBolivia]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpChile]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpColombia]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpCostaRica]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpDominicana]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpEcuador]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpGuatemala]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpMexico]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpPanama]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpPeru]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpPuertoRico]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpSalvador]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO

/*end*/

USE [BelcorpVenezuela]
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCompartido'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCompartido
END

GO

CREATE PROCEDURE GetProductoCompartido
(
@ProductoCompID int
)
AS
BEGIN
	select 
		ProductoCompID,
		CampaniaID,
		CUV,
		Palanca,
		Detalle,
		Applicacion
	 from dbo.ProductoCompartido 
	 where ProductoCompID = @ProductoCompID
END

GO


