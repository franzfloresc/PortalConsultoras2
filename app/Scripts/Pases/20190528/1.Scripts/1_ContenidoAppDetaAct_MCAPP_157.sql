USE BelcorpPeru
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpMexico
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpColombia
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpSalvador
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpPuertoRico
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpPanama
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpGuatemala
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpEcuador
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpDominicana
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpCostaRica
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpChile
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)

USE BelcorpBolivia
GO

GO
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDetaAct') AND TYPE = 'U')
   DROP TABLE DBO.ContenidoAppDetaAct
GO

CREATE TABLE [dbo].[ContenidoAppDetaAct](
	[IdContenidoAct] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Parent] [int] NULL,
	[Orden] [int] NULL,
	[Activo] [bit] NULL,
	PRIMARY KEY( IdContenidoAct )
)