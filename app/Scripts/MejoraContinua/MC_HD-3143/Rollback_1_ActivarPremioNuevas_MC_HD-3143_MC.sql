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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
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
	[CodigoPrograma] [varchar](10) NOT NULL,
	[AnoCampana] [int] NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL,
	[IND_CUPO_ELEC] [bit] NULL
 CONSTRAINT [PK_ActivarPremioNueva] PRIMARY KEY CLUSTERED 
(
	[CodigoPrograma] ASC,
	[AnoCampana] ASC,
	[Nivel] ASC
))
GO

