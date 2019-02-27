USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP TABLE [dbo].[ActivarPremioNuevas]
GO


CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NOT NULL,
	ActiveMonto  [bit] NOT NULL,
	ActivePremioAuto  [bit] NOT NULL,
	[FechaCreate] [datetime] NOT NULL DEFAULT (getdate()),
	ActivePremioElectivo  [bit] NULL,
	PRIMARY KEY CLUSTERED 
	(
	   [IdActivarPremioNuevas] ASC
	)
) 

GO

