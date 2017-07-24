
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = CAST((CAST(AVG( CONVERT(FLOAT,Valorizado)) AS FLOAT)/5)*100 AS INT)  
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO

