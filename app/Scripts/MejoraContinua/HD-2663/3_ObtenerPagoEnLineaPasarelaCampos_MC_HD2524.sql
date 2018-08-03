IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaPasarelaCampos', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerPagoEnLineaPasarelaCampos
GO
CREATE PROCEDURE dbo.ObtenerPagoEnLineaPasarelaCampos
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		PagoEnLineaPasarelaCamposId,
		Codigo,
		Descripcion,
		EsObligatorio,
		Estado
	FROM dbo.PagoEnLineaPasarelaCampos
	WHERE Estado = 1;
END