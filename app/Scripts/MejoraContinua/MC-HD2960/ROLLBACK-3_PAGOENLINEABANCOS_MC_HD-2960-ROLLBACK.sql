USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'dbo.ObtenerPagoEnLineaURLPaginasBancos') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE ObtenerPagoEnLineaURLPaginasBancos
GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PagoEnLineaBancos') AND TYPE = 'U')
   DROP TABLE PagoEnLineaBancos
GO

if(select count(*) from PagoEnLineaMedioPago where Codigo='PBI')=1
 delete from PagoEnLineaMedioPago where Codigo='PBI'
go

