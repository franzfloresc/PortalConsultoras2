DECLARE @ConfiguracionPais INT = (SELECT configuracionpaisID FROM configuracionpais WHERE Codigo = 'HV' )

IF NOT EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTitulo')
BEGIN
	INSERT configuracionpaisdatos
	(
		ConfiguracionPaisID	, Codigo				, CampaniaID	, Valor1									, Valor2									, Valor3	, Descripcion							, Estado	, Componente
	)
	VALUES
	(
		@ConfiguracionPais	, 'BannerCarruselTitulo', 0				,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'	,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'	,NULL		,'Texto para el banner del carrusel'	,'1'		,'BannerCarrusel'
	)
END

IF NOT EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTextoEnlace')
BEGIN
	INSERT configuracionpaisdatos
	(
		ConfiguracionPaisID	, Codigo						, CampaniaID	, Valor1	, Valor2	, Valor3	, Descripcion			, Estado	, Componente
	)
	VALUES
	(
		@ConfiguracionPais	, 'BannerCarruselTextoEnlace'	, 0				,'VER MÁS'	, 'VER MÁS'	, NULL		,'Texto para el botón'	,'1'		,'BannerCarrusel'
	)
END

IF NOT EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselImagenFondo')
BEGIN
	INSERT configuracionpaisdatos
	(
		ConfiguracionPaisID	, Codigo						, CampaniaID	, Valor1						, Valor2						, Valor3	, Descripcion						, Estado	, Componente
	)
	VALUES
	(
		@ConfiguracionPais	, 'BannerCarruselImagenFondo'	, 0				,'banner_carrusel_desktop.jpg'	,'banner_carrusel_desktop.jpg'	,NULL		,'Imagen de fondo para el banner'	, '1'		,'BannerCarrusel'
	)
END