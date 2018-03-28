USE BelcorpPeru
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpMexico
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpColombia
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpSalvador
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpPuertoRico
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpPanama
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpGuatemala
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpEcuador
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpDominicana
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpCostaRica
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpChile
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO

USE BelcorpBolivia
GO

BEGIN
print DB_NAME();

declare @RevistaDigitalId int = 0;
declare @RevistaDigitalCodigo varchar(30) = 'RD';

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

END
GO