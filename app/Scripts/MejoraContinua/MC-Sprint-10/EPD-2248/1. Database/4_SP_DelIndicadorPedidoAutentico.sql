
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.DelIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.DelIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE DelIndicadorPedidoAutentico
(
	@PedidoID INT,
	@CampaniaID INT,
	@PedidoDetalleID INT
)
AS
BEGIN

	DELETE FROM IndicadorPedidoAutentico
	WHERE PedidoID = @PedidoID
	AND CampaniaID = @CampaniaID
	AND PedidoDetalleID = @PedidoDetalleID
END
GO


