USE BelcorpPeru
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpMexico
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpColombia
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpSalvador
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpPuertoRico
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpPanama
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpGuatemala
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpEcuador
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpDominicana
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpCostaRica
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpChile
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO

USE BelcorpBolivia
GO

BEGIN
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
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'NSPerdiste',0,'Únete al club y','obtén ofertas adicionales','','No Suscrita Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'SNAPerdiste')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : SNAPerdiste')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'SNAPerdiste',0,'tendrás estas ofertas adicionales','desde la #campania','','Suscrita No Activa Ofertas',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoNS')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoNS')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoNS',0,'¿LO QUIERES?','ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+','','Popup Bloqueado No Suscrita',1,null);
END

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @RevistaDigitalId AND  Codigo = 'PopupBloqueadoSNA')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : PopupBloqueadoSNA')
	insert into [ConfiguracionPaisDatos](ConfiguracionPaisID,Codigo,CampaniaID,Valor1,Valor2,Valor3,Descripcion,Estado,Componente) values
	(@RevistaDigitalId,'PopupBloqueadoSNA',0,'a partir de la #campania disfruta de','los beneficios del club gana+','','Popup Bloqueado Suscrita No Activa',1,null);
END
END
GO
