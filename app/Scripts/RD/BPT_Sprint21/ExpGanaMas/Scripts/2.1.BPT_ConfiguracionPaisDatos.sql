USE BelcorpPeru
GO

print DB_NAME()

declare @RevistaDigitalId int = 0
declare @RevistaDigitalCodigo varchar(30) = 'RD'

select 
@RevistaDigitalId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @RevistaDigitalCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'NSPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : NSPerdiste')
	insert into [ConfiguracionPaisDatos] values
	(@RevistaDigitalId,'NSPerdiste',0,'únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos] values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos] values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'aprovecha esta y más ofertas','suscribiéndote al club gana+','','Popup Bloqueado No Suscrita',1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos] values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
GO