USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END
GO
CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoGeneradoID] [int] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[OrigenID] [int] NOT NULL,	
	[OrigenDescripcion] [varchar](50) NULL,
	[TipoEnvio] [varchar](10) NULL,	
	[CodigoGenerado] [varchar](6) NULL,
	[OpcionDesabilitado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_CodigoGenerado] PRIMARY KEY CLUSTERED 
(
	[CodigoGeneradoID] ASC,
	[CodigoUsuario] ASC,
	[OrigenID] ASC
))
GO

