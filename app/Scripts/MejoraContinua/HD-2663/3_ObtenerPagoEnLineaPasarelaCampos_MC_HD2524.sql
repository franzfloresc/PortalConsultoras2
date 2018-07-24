--ALL
CREATE PROCEDURE dbo.ObtenerPagoEnLineaPasarelaCampos
as
begin

SELECT 
	PagoEnLineaPasarelaCamposId,
	Codigo,
	Descripcion,
	EsObligatorio,
	Estado
FROM dbo.PagoEnLineaPasarelaCampos
WHERE Estado = 1;
end