USE BelcorpPeru
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpMexico
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpColombia
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpSalvador
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpPanama
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpGuatemala
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpEcuador
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpDominicana
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpCostaRica
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpChile
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

USE BelcorpBolivia
GO

IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO
create table PagoEnLineaBancos
(
  Id int identity(1,1) primary key,
  Banco varchar(100),
  URlPaginaWeb varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/',1)
insert into PagoEnLineaBancos values('VCP','https://www.viabcp.com/',1)
insert into PagoEnLineaBancos values('BancoNacion','http://www.bn.com.pe/',1)
insert into PagoEnLineaBancos values('Multifacil','http://www.multifacil.com.pe/',1)
insert into PagoEnLineaBancos values('WesterUnion','https://www.westernunion.com.pe/',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/',1)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
create procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
		SELECT STUFF(
		(SELECT '¦' + UrlPaginaWeb
		FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH ('')),1,1, '')
end
GO

