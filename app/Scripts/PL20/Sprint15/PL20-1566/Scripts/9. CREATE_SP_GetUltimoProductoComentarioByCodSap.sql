
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO

/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND c.Estado = 1
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE c.CodigoSap = @CodigoSap AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO


