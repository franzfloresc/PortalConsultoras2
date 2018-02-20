USE BelcorpPeru
GO

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
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
