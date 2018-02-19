USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = 18 AND  Codigo = 'MPopupBloqueado'
	)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = 18 AND  Codigo = 'MPopupBloqueado'
END
GO

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = 18 AND  Codigo = 'DPopupBloqueado'
	)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = 18 AND  Codigo = 'DPopupBloqueado'
END
GO