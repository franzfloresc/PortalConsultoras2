
ALTER PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0) 
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end

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
	
	set @NroLote = @NumeroLote

END


