USE BelcorpMexico
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
			SET StockInicial = t.Stock
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



USE BelcorpPeru
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
			SET StockInicial = t.Stock
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

USE BelcorpBolivia
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
			SET StockInicial = t.Stock
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
	

USE BelcorpChile
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
			SET StockInicial = t.Stock
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


USE BelcorpColombia
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
			SET StockInicial = t.Stock
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


USE BelcorpCostaRica
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
			SET StockInicial = t.Stock
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

USE BelcorpDominicana
GO
/****** Object:  StoredProcedure [dbo].[UpdStockOfertaProductoMasivo]    Script Date: 30/01/2019 15:21:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
			SET StockInicial = t.Stock
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




USE BelcorpEcuador
GO
/****** Object:  StoredProcedure [dbo].[UpdStockOfertaProductoMasivo]    Script Date: 30/01/2019 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
			SET StockInicial = t.Stock
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

USE BelcorpGuatemala
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
			SET StockInicial = t.Stock
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


USE BelcorpPanama
GO
/****** Object:  StoredProcedure [dbo].[UpdStockOfertaProductoMasivo]    Script Date: 30/01/2019 15:24:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
			SET StockInicial = t.Stock
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


USE BelcorpPuertoRico
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
			SET StockInicial = t.Stock
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

USE BelcorpSalvador
GO
/****** Object:  StoredProcedure [dbo].[UpdStockOfertaProductoMasivo]    Script Date: 30/01/2019 15:26:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
			SET StockInicial = t.Stock
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