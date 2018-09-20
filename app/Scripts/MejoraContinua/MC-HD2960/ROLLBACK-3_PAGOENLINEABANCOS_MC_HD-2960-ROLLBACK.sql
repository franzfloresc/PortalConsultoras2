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


