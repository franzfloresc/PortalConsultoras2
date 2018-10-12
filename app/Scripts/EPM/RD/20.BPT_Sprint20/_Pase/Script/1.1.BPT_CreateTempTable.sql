USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
	DROP TABLE [ConsultoraNuevaTemporal]
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsultoraNuevaTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [ConsultoraNuevaTemporal]
	(
		[CodigoConsultora] [varchar](55) NULL,
		[Campania] [varchar](6) NULL,
		[Origen] [varchar](55) NULL -- Registrada (activa), Egreso/Egresada, Retirada (activa)
	)
END
GO

