
USE BelcorpBolivia
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpChile
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpColombia
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpCostaRica
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpDominicana
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpEcuador
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpGuatemala
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpMexico
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpPanama
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpPeru
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpPuertoRico
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO

USE BelcorpSalvador
GO

DECLARE @cpid INT

SELECT @cpid = ConfiguracionPaisId
FROM ConfiguracionPais
WHERE Codigo = 'SR'

IF isnull(@cpid, 0) != 0
BEGIN
	UPDATE ConfiguracionOfertasHome
	SET DesktopTipoPresentacion = 5
		,MobileTipoPresentacion = 4
	WHERE ConfiguracionPaisId = @cpid
		AND (
			DesktopActivo = 1
			AND MobileActivo = 1
			)
END
GO
