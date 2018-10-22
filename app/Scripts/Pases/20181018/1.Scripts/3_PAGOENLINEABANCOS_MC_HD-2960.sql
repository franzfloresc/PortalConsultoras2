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
  URLIcono varchar(800),
  Estado bit
)
go
insert into PagoEnLineaBancos values('Interbank','https://www.interbank.pe/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/interbank.png',1)
insert into PagoEnLineaBancos values('Scotiabank','https://www.scotiabank.com.pe','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/scotiabank.png',1)
insert into PagoEnLineaBancos values('Continental','https://www.bbvacontinental.pe/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/bbva.png',1)
insert into PagoEnLineaBancos values('BCP','https://www.viabcp.com/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/bcp.png',1)
insert into PagoEnLineaBancos values('Banco de la Nación','http://www.bn.com.pe/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/banco_de_la_nacion.png',1)
insert into PagoEnLineaBancos values('Wester Unión','https://www.westernunion.com.pe/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/w_u.png',1)
insert into PagoEnLineaBancos values('Pichincha','https://www.pichincha.pe/','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/banco_p.png',1)

if( select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=0
insert into PagoEnLineaMedioPago values('PAGOS BANCA POR INTERNET','PBI','https://somosbelcorpqa.s3.amazonaws.com/PagoEnLinea/banca_internet_45px.png',3,'',1)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
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
  URLIcono varchar(800),
  Estado bit
)
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
CREATE procedure ObtenerPagoEnLineaURLPaginasBancos
as
begin
	   
	    IF(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)>0
	   	(Select STUFF((Select '¬' + Banco + '¦' + UrlPaginaWeb + '¦' + URLIcono  + '¦' +
		               (select top 1 rutaIcono from PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1 )
			FROM PagoEnLineaBancos where Estado=1
		FOR XML PATH('')), 1, 1, ''))
		ELSE
		SELECT 1
end
GO

