use [BelcorpBolivia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

use [BelcorpChile]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpColombia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpCostaRica]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpDominicana]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpEcuador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpGuatemala]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpMexico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPanama]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPeru]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPuertoRico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpSalvador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.PedidoDescargaValidador') AND TYPE = 'U')
   DROP TABLE PedidoDescargaValidador
GO

CREATE TABLE [dbo].[PedidoDescargaValidador](
	[NroPedidoDescargaValidador] [int] IDENTITY(1,1) NOT NULL,
	[NroLote] [int] NULL,
	[CampanaId] [int] NULL,
	[Estado] [tinyint] NOT NULL,
	[FechaProceso] [datetime2](0) NULL,
	[Usuario] [varchar](20) NULL,
 CONSTRAINT [PK_PedidoDescargaValidador] PRIMARY KEY CLUSTERED 
(
	[NroPedidoDescargaValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO







