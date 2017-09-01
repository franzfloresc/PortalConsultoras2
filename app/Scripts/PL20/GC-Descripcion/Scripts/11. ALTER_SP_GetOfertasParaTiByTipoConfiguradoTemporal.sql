USE BelcorpPeru
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpMexico
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpColombia
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpVenezuela
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpSalvador
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpPuertoRico
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpPanama
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpGuatemala
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpEcuador
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpDominicana
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpCostaRica
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpChile
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO
/*end*/

USE BelcorpBolivia
GO

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
		TieneVariedad INT
	)

	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	if @TipoConfigurado = 0
	begin
		insert into @tablaResultado
		select CUV, Descripcion, PrecioOferta, PrecioTachado, CodigoSap, OfertaUltimoMinuto, LimiteVenta, FotoProducto01,
			CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
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
				CodigoEstrategia, TieneVariedad
			from EstrategiaTemporal
			where 
				CampaniaId = @CampaniaID
				and Descripcion = ''
				and NumeroLote = @NumeroLote
		end
	end

	select * from @tablaResultado
end
GO