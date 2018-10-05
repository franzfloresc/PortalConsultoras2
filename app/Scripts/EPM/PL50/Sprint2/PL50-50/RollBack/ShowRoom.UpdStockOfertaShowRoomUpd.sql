USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd
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
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock += @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
	else
	  begin
	  		--- Si la cantidad anterior es mayor a la cantidad ingresada
			UPDATE ShowRoom.OfertaShowRoom
				SET Stock -= @Stock
				FROM ShowRoom.OfertaShowRoom o
				INNER JOIN ods.campania c
					on c.CampaniaID = o.CampaniaID
				WHERE 
					c.Codigo = @CampaniaID
					AND o.CUV = @CUVPadre
					AND o.TipoOfertaSisID = @TipoOfertaSisID
		end
END


GO

