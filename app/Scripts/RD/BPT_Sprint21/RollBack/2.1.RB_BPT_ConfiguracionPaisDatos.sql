USE BelcorpPeru
GO

print DB_NAME()

declare @RevistaDigitalId int = 0
declare @RevistaDigitalCodigo varchar(30) = 'RD'

select 
@RevistaDigitalId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @RevistaDigitalCodigo;


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @RevistaDigitalId 
			AND  Codigo = 'NSPerdiste')
BEGIN
	PRINT 'Eliminando NSPerdiste de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @RevistaDigitalId 
	AND  Codigo = 'NSPerdiste'
END
GO

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @RevistaDigitalId 
			AND  Codigo = 'SNAPerdiste')
BEGIN
	PRINT 'Eliminando SNAPerdiste de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @RevistaDigitalId 
	AND  Codigo = 'SNAPerdiste'
END
GO

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @RevistaDigitalId 
			AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	PRINT 'Eliminando PopupBloqueadoNS de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @RevistaDigitalId 
	AND  Codigo = 'PopupBloqueadoNS'
END
GO

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @RevistaDigitalId 
			AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	PRINT 'Eliminando PopupBloqueadoSNA de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @RevistaDigitalId 
	AND  Codigo = 'PopupBloqueadoSNA'
END
GO