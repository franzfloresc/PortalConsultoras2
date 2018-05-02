
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasPersonalizadasByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.GetOfertasPersonalizadasByTipoConfiguradoTemporal
GO

CREATE PROCEDURE  dbo.GetOfertasPersonalizadasByTipoConfiguradoTemporal
(
	@TipoConfigurado int,
	@nroLote int = 0
)
as
/*
exec GetOfertasPersonalizadasByTipoConfiguradoTemporal 201618,0
exec GetOfertasPersonalizadasByTipoConfiguradoTemporal 201618,1
exec GetOfertasPersonalizadasByTipoConfiguradoTemporal 201618,2
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

	SET @nroLote = ISNULL(@nroLote, 0)

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
		from EstrategiaTemporal
		where NumeroLote = @nroLote
	end
	else
	begin
		if @TipoConfigurado = 1
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
			from EstrategiaTemporal
			where Descripcion != ''
				and NumeroLote = @nroLote
		end
		else
		begin
			insert into @tablaResultado
			select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
				CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
			from EstrategiaTemporal
			where Descripcion = ''
				and NumeroLote = @nroLote
		end
	end

	select * from @tablaResultado
end

