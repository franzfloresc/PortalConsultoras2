use [BelcorpPeru_BPT]
go

begin

	declare @ConfiguracionPaisID int
	
	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'
	
	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

end;
go