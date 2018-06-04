GO
USE BelcorpPeru
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpMexico
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpColombia
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpSalvador
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpPuertoRico
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpPanama
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpGuatemala
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpEcuador
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpDominicana
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpCostaRica
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpChile
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
USE BelcorpBolivia
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
CREATE PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
@CampaniaID int,
@TipoConfigurado int,
@nroLote int = 0
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
	SET @nroLote = ISNULL(@nroLote, 0)

	declare @NumeroLote int = 0
	IF @nroLote <= 0
		select @NumeroLote = max(NumeroLote) from EstrategiaTemporal
	ELSE
		SET @NumeroLote = @nroLote
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
GO

GO
