USE BelcorpPeru
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EstrategiaProductoTemporal](
		[Campania] [int] NOT NULL,
		[Cuv] [varchar](6) NOT NULL,
		[CuvPadre] [varchar](6) NOT NULL,
		[CodigoEstrategia] [varchar](6) NOT NULL,
		[Grupo] [int] NULL,
		[CodigoSap] [varchar] (9) NULL,
		[Cantidad] [int] NULL,
		[PrecioUnitario] [decimal](18,2) NULL,
		[PrecioValorizado] [decimal](18,2) NULL,
		[Orden] [int] NULL,
		[Digitable] [int] NULL,
		[FactorCuadre] [int] NULL,
		[Descripcion] [varchar](800) NULL,
		[IdMarca] [int] NULL
	)
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U')) 
	AND NOT EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	CREATE INDEX EstrategiaProductoTemporaIndex1 ON EstrategiaProductoTemporal (Campania, CuvPadre);
END
GO

