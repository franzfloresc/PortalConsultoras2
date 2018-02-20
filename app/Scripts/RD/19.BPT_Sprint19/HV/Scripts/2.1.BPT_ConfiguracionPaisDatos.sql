USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = 18 AND  Codigo = 'MPopupBloqueado')
BEGIN
	
	insert into [ConfiguracionPaisDatos] values
	(18,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = 18 AND  Codigo = 'DPopupBloqueado')
BEGIN
	insert into [ConfiguracionPaisDatos] values
	(18,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO
