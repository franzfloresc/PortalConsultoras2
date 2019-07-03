use [BelcorpBolivia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

use [BelcorpChile]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpColombia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpCostaRica]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpDominicana]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpEcuador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpGuatemala]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpMexico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPanama]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPeru]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPuertoRico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpSalvador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaSinMarcar') AND TYPE = 'U')
   DROP TABLE PedidoDescargaSinMarcar
GO


CREATE TABLE [dbo].[PedidoDescargaSinMarcar](
	[NroLote] [int] NOT NULL,
	[TipoCronograma] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaFin] [datetime2](0) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[Usuario] [varchar](20) NULL,
	[NombreArchivoCabecera] [varchar](100) NULL,
	[NombreArchivoDetalle] [varchar](100) NULL,
	[NombreServer] [varchar](100) NULL,
	[MensajeExcepcion] [nvarchar](2000) NULL,
 CONSTRAINT [PK_PedidoDescargaSinCargar] PRIMARY KEY CLUSTERED 
(
	[NroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





