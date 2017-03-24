use [BelcorpBolivia]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO


use [BelcorpChile]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO


use [BelcorpColombia]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO


use [BelcorpCostaRica]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpDominicana]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpEcuador]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO


use [BelcorpGuatemala]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpMexico]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpPanama]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpPeru]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpPuertoRico]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpSalvador]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO



use [BelcorpVenezuela]
GO
if exists (select * from sys.objects where type = 'U' and name like '%TipoOperacionesCDR%')
begin 
	DROP TABLE [dbo].[TipoOperacionesCDR]
	print 'elimino'
end

	CREATE TABLE [dbo].[TipoOperacionesCDR](
		[CodigoOperacion] [varchar](2) NULL,
		[DescripcionOperacion] [varchar](40) NULL,
		[NumeroDiasAtrasOperacion] [numeric](2, 0) NULL
	) ON [DATA]

	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'C', N'Canje de Mercaderia', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'D', N'Devolución Normal', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'T', N'Trueque de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'F', N'Faltante de Mercadería', CAST(21 AS Numeric(2, 0)))
	INSERT [dbo].[TipoOperacionesCDR] ([CodigoOperacion], [DescripcionOperacion], [NumeroDiasAtrasOperacion]) VALUES (N'G', N'Faltante de Mercaderia con Abono', CAST(21 AS Numeric(2, 0)))
	print 'inserto'
GO