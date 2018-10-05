
ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,0
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,1
exec GetOfertasParaTiByTipoConfiguradoTemporal 201618,2
*/
begin

	declare @tablaResultado table (
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(100),
		Precio2 decimal(18,2),
		Precio decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(150),
		CodigoEstrategia varchar(150), 
		TieneVariedad INT,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2),
		Niveles varchar(255)
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
		from EstrategiaTemporal
		where 
			CampaniaId = @CampaniaID
			and NumeroLote = @NumeroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion != ''
				and NumeroLote = @NumeroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
