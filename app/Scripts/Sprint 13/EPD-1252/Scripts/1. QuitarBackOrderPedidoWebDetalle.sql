

USE BelcorpBolivia
GO


IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID(N'dbo.QuitarBackOrderPedidoWebDetalle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
END

GO

CREATE PROCEDURE [dbo].[QuitarBackOrderPedidoWebDetalle]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT
AS
BEGIN
	UPDATE dbo.PedidoWebDetalle
	SET
		EsBackOrder = 0,
		AceptoBackOrder = 0
	WHERE
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
		AND PedidoDetalleID = @PedidoDetalleID;
END

GO

