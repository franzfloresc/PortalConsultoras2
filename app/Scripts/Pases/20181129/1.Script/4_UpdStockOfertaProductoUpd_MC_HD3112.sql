USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoUpd]
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int,
	@Flag int
AS
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	if @Flag = 1
		begin
		--- Si la cantidad ingresada es mayor a la anterior
			UPDATE dbo.OfertaProducto
					SET Stock -= @Stock
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  --- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE dbo.OfertaProducto
					SET Stock += case when @Stock < 0 and ABS(@Stock) > o.Stock then - o.Stock else @Stock end
				FROM dbo.OfertaProducto o
					 JOIN ods.campania c
					 on c.CampaniaID = o.CampaniaID
				WHERE c.Codigo = @CampaniaID
					  AND o.CUV = @CUVPadre
					  AND o.TipoOfertaSisID = @TipoOfertaSisID
					  AND ((@Stock < 0 and o.Stock != 0)
					  OR @Stock > 0)
		end
END
GO

