USE BelcorpPeru
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpMexico
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpColombia
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpSalvador
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpPuertoRico
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpPanama
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpGuatemala
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpEcuador
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpDominicana
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpCostaRica
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpChile
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

USE BelcorpBolivia
GO

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

