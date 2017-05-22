----------------------------------------------------------------------------------------------------
-- CREACION DE LA TABLA ESTRATEGIA DETALLE PARA ALMACENA LAS IMAGENES ADICIONALES (TODOS LOS PAISES)
----------------------------------------------------------------------------------------------------
USE BelcorpPeru
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpMexico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpColombia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpVenezuela
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpSalvador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpPuertoRico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpPanama
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpGuatemala
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpEcuador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpDominicana
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpCostaRica
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpChile
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO

USE BelcorpBolivia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[EstrategiaDetalle]') AND (type = 'U') )
	DROP TABLE EstrategiaDetalle
GO

CREATE TABLE [dbo].[EstrategiaDetalle](
	[EstrategiaDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaID] [int] NOT NULL,
	[TablaLogicaDatosID] [smallint] NOT NULL,
	[Valor] [varchar](500) NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [bit] NOT NULL
)
GO