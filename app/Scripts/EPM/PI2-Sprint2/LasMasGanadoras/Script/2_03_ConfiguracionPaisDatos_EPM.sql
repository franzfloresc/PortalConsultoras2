use [BelcorpPeru_BPT]
go

begin

	declare @ConfiguracionPaisID int
	
	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'
	
	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'DESCUBRE OFERTAS M�S DE NAVIDAD'
		,'DESCUBRE OFERTAS M�S DE NAVIDAD'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);

		
	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER M�S +'
		,'VER M�S +'
		,null
		,'Texto para el boton'
		,1
		,'BannerCarrusel'
		);
end;
go