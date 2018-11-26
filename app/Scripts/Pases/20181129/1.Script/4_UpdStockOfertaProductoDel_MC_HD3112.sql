USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoDel]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE dbo.OfertaProducto
			SET Stock -= case when @Stock > o.Stock then o.Stock else @Stock end 
		FROM dbo.OfertaProducto o
			 JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE c.Codigo = @CampaniaID
			  AND o.CUV = @CUVPadre
			  AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

