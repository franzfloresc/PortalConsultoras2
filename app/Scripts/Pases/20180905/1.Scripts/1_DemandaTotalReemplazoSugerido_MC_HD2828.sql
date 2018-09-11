USE BelcorpPeru
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from SYSOBJECTS where type = 'U' and id = OBJECT_ID('[dbo].[DemandaTotalReemplazoSugerido]'))
BEGIN
	DROP TABLE [dbo].[DemandaTotalReemplazoSugerido]
END
CREATE TABLE [dbo].[DemandaTotalReemplazoSugerido](
	[SugeridoID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[ConsultoraID] [int] NULL,
	[CUVOriginal] [varchar](20) NULL,
	[CUVSugerido] [varchar](20) NULL,
	[Aceptado] [bit] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [money] NULL,
	[Tipo] [varchar](20) NULL,
	[FechaProceso] [datetime] NULL,
 CONSTRAINT [PK_DemandaTotalReemplazoSugerido] PRIMARY KEY CLUSTERED 
(
	[SugeridoID] ASC
))
GO

