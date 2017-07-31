USE [BelcorpPeru]
GO
/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
if exists(select 1 from sysobjects where name = 'GetListaProductoOfertaFinal' and xtype = 'p')
drop procedure GetListaProductoOfertaFinal
go
if exists(select 1 from sysobjects where name = 'GetListaProductoCrossSelling' and xtype = 'p')
drop procedure GetListaProductoCrossSelling
go
DROP TYPE [dbo].[ListaOfertaFinalType]
GO

/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
CREATE TYPE [dbo].[ListaOfertaFinalType] AS TABLE(
	[CampaniaID] [int] NULL,
	[CodigoConsultora] [varchar](30) NULL,
	[ZonaID] [int] NULL,
	[CodigoRegion] [varchar](8) NULL,
	[CodigoZona] [varchar](8) NULL,
	[MontoMinimo] [decimal](15, 2) NULL,
	[MontoTotal] [money] NULL,
	[MontoEscala] [money] NULL,
	Algoritmo varchar(10) NULL
)
GO
USE [BelcorpColombia]
GO
/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
if exists(select 1 from sysobjects where name = 'GetListaProductoOfertaFinal' and xtype = 'p')
drop procedure GetListaProductoOfertaFinal
go
if exists(select 1 from sysobjects where name = 'GetListaProductoCrossSelling' and xtype = 'p')
drop procedure GetListaProductoCrossSelling
go
DROP TYPE [dbo].[ListaOfertaFinalType]
GO

/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
CREATE TYPE [dbo].[ListaOfertaFinalType] AS TABLE(
	[CampaniaID] [int] NULL,
	[CodigoConsultora] [varchar](30) NULL,
	[ZonaID] [int] NULL,
	[CodigoRegion] [varchar](8) NULL,
	[CodigoZona] [varchar](8) NULL,
	[MontoMinimo] [decimal](15, 2) NULL,
	[MontoTotal] [money] NULL,
	[MontoEscala] [money] NULL,
	Algoritmo varchar(10) NULL
)
GO
GO
USE [BelcorpMexico]
GO
/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
if exists(select 1 from sysobjects where name = 'GetListaProductoOfertaFinal' and xtype = 'p')
drop procedure GetListaProductoOfertaFinal
go
if exists(select 1 from sysobjects where name = 'GetListaProductoCrossSelling' and xtype = 'p')
drop procedure GetListaProductoCrossSelling
go
DROP TYPE [dbo].[ListaOfertaFinalType]
GO

/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
CREATE TYPE [dbo].[ListaOfertaFinalType] AS TABLE(
	[CampaniaID] [int] NULL,
	[CodigoConsultora] [varchar](30) NULL,
	[ZonaID] [int] NULL,
	[CodigoRegion] [varchar](8) NULL,
	[CodigoZona] [varchar](8) NULL,
	[MontoMinimo] [decimal](15, 2) NULL,
	[MontoTotal] [money] NULL,
	[MontoEscala] [money] NULL,
	Algoritmo varchar(10) NULL
)
GO

USE [BelcorpChile]
GO
/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
if exists(select 1 from sysobjects where name = 'GetListaProductoOfertaFinal' and xtype = 'p')
drop procedure GetListaProductoOfertaFinal
go
if exists(select 1 from sysobjects where name = 'GetListaProductoCrossSelling' and xtype = 'p')
drop procedure GetListaProductoCrossSelling
go
DROP TYPE [dbo].[ListaOfertaFinalType]
GO

/****** Object:  UserDefinedTableType [dbo].[ListaOfertaFinalType]    Script Date: 26/07/2017 09:55:43 a.m. ******/
CREATE TYPE [dbo].[ListaOfertaFinalType] AS TABLE(
	[CampaniaID] [int] NULL,
	[CodigoConsultora] [varchar](30) NULL,
	[ZonaID] [int] NULL,
	[CodigoRegion] [varchar](8) NULL,
	[CodigoZona] [varchar](8) NULL,
	[MontoMinimo] [decimal](15, 2) NULL,
	[MontoTotal] [money] NULL,
	[MontoEscala] [money] NULL,
	Algoritmo varchar(10) NULL
)
GO

