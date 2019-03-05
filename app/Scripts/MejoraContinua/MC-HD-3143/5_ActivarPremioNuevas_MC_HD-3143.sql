USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActivarPremioNuevas]') 
	AND type in (N'U')
) 
   DROP PROCEDURE [dbo].[dbo].[ActivarPremioNuevas]
GO

CREATE TABLE [dbo].[ActivarPremioNuevas](
	[IdActivarPremioNuevas] [int] IDENTITY(1,1) NOT NULL,
	[CodigoPrograma] [varchar](10) NOT NULL,
	[Nivel] [varchar](10) NOT NULL,
	[AnoCampanaIni] [int] NOT NULL,
	[AnoCampanaFin] [int] NOT NULL,
	[ActiveTooltip] [bit] NULL,
	[ActiveTooltipMonto] [bit] NULL,
	[Active] [bit] NULL,
	[FechaCreate] [datetime] NULL DEFAULT (getdate()),
	[IND_CUPO_ELEC] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdActivarPremioNuevas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

