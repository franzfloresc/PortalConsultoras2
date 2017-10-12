GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO