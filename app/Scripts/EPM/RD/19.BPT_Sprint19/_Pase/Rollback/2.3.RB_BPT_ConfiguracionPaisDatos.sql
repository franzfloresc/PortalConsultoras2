USE BelcorpPeru
GO

print DB_NAME()

declare @HerramientasVentaId int = 0
declare @HerramientasVentaCodigo varchar(30) = 'HV'

select 
@HerramientasVentaId = cp.ConfiguracionPaisID
from ConfiguracionPais cp
where cp.Codigo = @HerramientasVentaCodigo;


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
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


IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'MPopupBloqueado')
BEGIN
	PRINT 'Eliminando MPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'MPopupBloqueado'
END

IF EXISTS(	SELECT 1 
			FROM ConfiguracionPaisDatos CPD
			WHERE ConfiguracionPaisID = @HerramientasVentaId 
			AND  Codigo = 'DPopupBloqueado')
BEGIN
	PRINT 'Eliminando DPopupBloqueado de ConfiguracionPaisDatos'
	DELETE 
	FROM ConfiguracionPaisDatos 
	WHERE ConfiguracionPaisID = @HerramientasVentaId 
	AND  Codigo = 'DPopupBloqueado'
END
GO

