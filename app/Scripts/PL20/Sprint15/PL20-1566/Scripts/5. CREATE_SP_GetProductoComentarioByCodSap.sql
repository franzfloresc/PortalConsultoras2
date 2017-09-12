
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO



