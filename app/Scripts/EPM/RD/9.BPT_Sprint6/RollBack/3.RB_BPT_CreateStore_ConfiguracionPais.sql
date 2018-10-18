USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisList]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisList
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisGet
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisUpdate]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionPaisUpdate
GO