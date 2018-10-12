USE BelcorpPeru
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpMexico
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpColombia
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpVenezuela
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpSalvador
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpPuertoRico
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpPanama
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpGuatemala
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpEcuador
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpDominicana
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpCostaRica
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpChile
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

USE BelcorpBolivia
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'MPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : MPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'MPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

IF NOT EXISTS(SELECT 1 FROM ConfiguracionPaisDatos CPD
	WHERE ConfiguracionPaisID = @HerramientasVentaId AND  Codigo = 'DPopupBloqueado')
BEGIN
	print('Insertando en ConfiguracionPaisDatos : DPopupBloqueado')
	insert into [ConfiguracionPaisDatos] values
	(@HerramientasVentaId,'DPopupBloqueado',0,'A partir de la próxima campaña, disfrutarás de este y muchos más beneficios.',
	null,null,null,1,null);
END
GO

