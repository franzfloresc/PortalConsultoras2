USE BelcorpBolivia;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpChile;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpColombia;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpCostaRica;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpDominicana;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpEcuador;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpGuatemala;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpMexico;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpPanama;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpPeru;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpPuertoRico;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
USE BelcorpSalvador;
GO
ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END


GO
