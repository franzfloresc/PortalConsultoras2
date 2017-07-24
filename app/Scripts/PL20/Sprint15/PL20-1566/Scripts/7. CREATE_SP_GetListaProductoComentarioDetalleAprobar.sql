

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO
--

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	DECLARE @ProductoComentarioDetalle TABLE(
		ProdComentarioId int
		,ProdComentarioDetalleId bigint
		,Valorizado tinyint
		,Comentario varchar(400)
		,FechaRegistro DATE
		,CodigoConsultora varchar(20)
		,Estado tinyint
	)
	DECLARE @TotalFilas INT

	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN

		SELECT 
		@CodigoSap = SP.CodigoSap, 
		@CodigoGenerico = RTRIM(SP.CodigoGenerico) 
		FROM ods.ProductoComercial PC
			JOIN ods.SAP_PRODUCTO SP ON PC.CodigoProducto = SP.CodigoSap
			AND PC.AnoCampania = @CampaniaId
			AND PC.CUV = @Codigo
			AND PC.EstadoActivo = 1
	END

	INSERT INTO @ProductoComentarioDetalle
	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND ISNULL(c.CodigoGenerico,'') = CASE WHEN @Tipo = 1 THEN ISNULL(c.CodigoGenerico,'') ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro

	SELECT @TotalFilas = COUNT(0)
	FROM @ProductoComentarioDetalle 
	
	SELECT 
	ProdComentarioId ,
	ProdComentarioDetalleId ,
	Valorizado ,
	Comentario ,
	FechaRegistro ,
	CodigoConsultora ,
	Estado ,
	TotalFilas = @TotalFilas
	FROM @ProductoComentarioDetalle
	ORDER BY FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO

