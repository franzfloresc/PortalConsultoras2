GO
USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[InsertPedidoWebPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[InsertPedidoWebPromocion]
GO

CREATE PROCEDURE [dbo].[InsertPedidoWebPromocion]
	@CuvPromocion varchar(10),
	@CuvCondicion varchar(10),
	@CampaniaID int
AS
BEGIN

	BEGIN TRY
		INSERT INTO PedidoWebPromocion(
		CuvPromocion,
		CuvCondicion,
		CampaniaID)
		VALUES (@CuvPromocion,@CuvCondicion,@CampaniaID)

		SELECT 1;
	END TRY
	BEGIN CATCH
		 SELECT 0;
	END CATCH
END

GO
