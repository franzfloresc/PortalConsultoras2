GO
USE BelcorpPeru
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpMexico
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpColombia
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpSalvador
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpPuertoRico
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpPanama
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpGuatemala
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpEcuador
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpDominicana
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpCostaRica
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpChile
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
USE BelcorpBolivia
GO
IF (OBJECT_ID ( 'dbo.ObtenerNumeroOrdenPagoEnLinea', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
GO
CREATE PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

GO
