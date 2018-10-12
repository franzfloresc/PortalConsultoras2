GO
USE BelcorpPeru
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpMexico
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpColombia
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpSalvador
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpPuertoRico
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpPanama
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpGuatemala
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpEcuador
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpDominicana
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpCostaRica
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpChile
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
USE BelcorpBolivia
GO

go
PRINT DB_NAME()
GO
IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END
PRINT 'CREANDO SINONIMO [ods].[ProductoNivel]'

DECLARE @vbCrLf varchar(2);
SET @vbCrLf = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2), @DbSigla varchar(50) = ''
SELECT @CodigoISO = convert(varchar(2), CodigoISO ) FROM PAIS where EstadoActivo = 1
set @DbSigla = DB_NAME()

if (select count(*) from [dbo].[fnSplit](@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_')
	set @DbSigla = '_' + @DbSigla
end
else
	set @DbSigla = ''
declare @SQLString varchar(max)
set @SQLString = 'CREATE SYNONYM [ods].[ProductoNivel] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[ProductoNivel]';

exec(@SQLString)
GO


GO
