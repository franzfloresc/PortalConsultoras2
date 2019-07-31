USE BelcorpBolivia
GO

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

USE BelcorpChile
GO

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

USE BelcorpColombia
GO

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

USE BelcorpCostaRica
GO

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

USE BelcorpDominicana
GO

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

USE BelcorpEcuador
GO

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

USE BelcorpGuatemala
GO

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

USE BelcorpMexico
GO

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

USE BelcorpPanama
GO

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

USE BelcorpPeru
GO

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

USE BelcorpPuertoRico
GO

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

USE BelcorpSalvador
GO

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