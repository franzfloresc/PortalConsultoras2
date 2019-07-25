DECLARE @ConfiguracionPais INT = (SELECT configuracionpaisID FROM configuracionpais WHERE Codigo = 'HV' )

IF EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTitulo')
BEGIN
	DELETE FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTitulo'
END

IF EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTextoEnlace')
BEGIN
	DELETE FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselTextoEnlace'
END

IF EXISTS(SELECT * FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselImagenFondo')
BEGIN
	DELETE FROM configuracionpaisdatos WHERE ConfiguracionPaisID = @ConfiguracionPais AND Codigo = 'BannerCarruselImagenFondo'
END