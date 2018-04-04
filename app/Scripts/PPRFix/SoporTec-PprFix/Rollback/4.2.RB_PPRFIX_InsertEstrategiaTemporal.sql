GO
ALTER PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = 0
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

END
GO