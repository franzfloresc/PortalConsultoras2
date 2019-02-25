USE BelcorpMexico_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			 ofertaproducto where CampaniaId = 3016


			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO



USE BelcorpPeru_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO

USE BelcorpBolivia_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO
	

USE BelcorpChile_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO


USE BelcorpColombia_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO


USE BelcorpCostaRica_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO

USE BelcorpDominicana_MC
GO

ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO

USE BelcorpEcuador_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO

USE BelcorpGuatemala_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO


USE BelcorpPanama_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO


USE BelcorpPuertoRico_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END

GO
USE BelcorpSalvador_MC
GO
ALTER PROCEDURE [dbo].[UpdStockOfertaProductoMasivo]
(
	@StockProducto dbo.StockProductoType readonly
)
AS
BEGIN
DECLARE @RowsUpdate INT
/*DECLARE @TableCount INT
DECLARE @Count  int
DECLARE @CUV VARCHAR(20)
DECLARE @CampaniaID int
DECLARE @Stock int
DECLARE @StockProductoTemp table
(
	CampaniaID int,
	CUV varchar(20),
	Stock int
)
INSERT INTO @StockProductoTemp
select CampaniaID, CUV, Stock
from @StockProducto*/
	UPDATE dbo.OfertaProducto
			SET Stock = t.Stock,
				StockInicial = t.Stock
			FROM dbo.OfertaProducto o
				JOIN ods.campania c
				 on c.CampaniaID = o.CampaniaID
				 JOIN @StockProducto t
				 ON c.Codigo = t.CampaniaID
				 AND o.CUV = t.CUV
				 AND o.TipoOfertaSisID = t.TipoOfertaSisID
	--SELECT @RowsUpdate = @@ROWCOUNT
	/*BEGIN TRANSACTION [Tran1]
		BEGIN TRY
		WHILE (Select Count(*) From @StockProductoTemp) > 0
		   BEGIN
			 Select Top 1 @CampaniaID = CampaniaID, @CUV = CUV, @Stock = Stock  From @StockProductoTemp

			  UPDATE OfertaProducto
				SET Stock = @Stock
			  WHERE CampaniaID = @CampaniaID 
					AND CUV = @CUV

			   DELETE FROM @StockProductoTemp 
			   Where CampaniaID = @CampaniaID 
					AND CUV = @CUV
			END
			COMMIT TRANSACTION [Tran1]
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION [Tran1]
		END CATCH*/
	END
GO