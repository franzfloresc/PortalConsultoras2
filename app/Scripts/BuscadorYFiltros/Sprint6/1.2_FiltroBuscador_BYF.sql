USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.FiltroBuscador') AND Type = N'U')
	DROP TABLE[dbo].[FiltroBuscador]

CREATE TABLE [dbo].[FiltroBuscador](
	[IdFiltroBuscador] [int] IDENTITY(1,1) NOT NULL,
	[TablaLogicaDatosID] [int] NULL, 
	[Estado] [bit] NOT NULL DEFAULT 1,
	[Codigo] [varchar](10) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Descripcion] [varchar](1000) NULL,
	[ValorMinimo] [varchar](200) NULL,
	[ValorMaximo] [varchar](200) NULL
)
GO

