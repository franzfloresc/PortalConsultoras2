USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO


USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='EstrategiaTemporalType')
    DROP TYPE EstrategiaTemporalType;
GO

/****** Object:  UserDefinedTableType [dbo].[EstrategiaTemporalType]    Script Date: 30/05/2017 03:17:14 p. m. ******/
CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,
	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL
)
GO





