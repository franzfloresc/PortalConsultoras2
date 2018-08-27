USE BelcorpBolivia
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'NivelesProgramaNuevas' AND TYPE = 'SN')
BEGIN
	DROP SYNONYM ods.NivelesProgramaNuevas
END
GO
declare @vbCrLf varchar(2) = CHAR(13) + CHAR(10);
declare @CodigoISO varchar(2) = (select top 1 convert(varchar(2), CodigoISO) from Pais where EstadoActivo = 1);
declare @DbSigla varchar(50) = DB_NAME();

if (select count(1) from dbo.fnSplit(@DbSigla, '_')) > 1
begin
	select @DbSigla = item from [dbo].[fnSplit](@DbSigla, '_');
	set @DbSigla = '_' + @DbSigla;
end
else
begin
	set @DbSigla = '';
end

declare @SQLString varchar(max) = 'CREATE SYNONYM [ods].[NivelesProgramaNuevas] FOR [ODS_' + @CodigoISO + @DbSigla + '].[dbo].[NivelesProgramaNuevas]';
exec(@SQLString);
GO