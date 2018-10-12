ALTER PROCEDURE dbo.ObtenerNumeroOrdenPagoEnLinea
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @orden INT;
	SELECT @orden = ISNULL(MAX(CAST(NumeroOrdenTienda AS Int)), 0) FROM dbo.PagoEnLineaResultadoLog
	WHERE IsNumeric(NumeroOrdenTienda) = 1

	SELECT @orden + 1;
END

