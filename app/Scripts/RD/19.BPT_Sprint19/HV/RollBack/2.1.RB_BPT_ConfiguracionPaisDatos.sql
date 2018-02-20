USE BelcorpPeru
GO

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;


IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado'
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