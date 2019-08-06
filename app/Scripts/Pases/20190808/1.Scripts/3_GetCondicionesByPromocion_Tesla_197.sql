GO
USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]')
	AND type in (N'P', N'PC')
)
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO


CREATE PROCEDURE [dbo].[GetCondicionesByPromocion]
	@CampaniaID INTEGER,
	@CuvPromocion VARCHAR(10)
AS
BEGIN
	SELECT
	CuvPromocion,
	CuvCondicion,
	CampaniaID
	FROM PedidoWebPromocion
	WHERE CuvPromocion = @CuvPromocion AND CampaniaID = @CampaniaID;
END

GO
