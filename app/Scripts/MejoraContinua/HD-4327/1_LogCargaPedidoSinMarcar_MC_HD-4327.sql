use [BelcorpBolivia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO

use [BelcorpChile]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO

use [BelcorpColombia]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpCostaRica]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpDominicana]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpEcuador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpGuatemala]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpMexico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPanama]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPeru]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpPuertoRico]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO





use [BelcorpSalvador]	
go
IF EXISTS (
SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.LogCargaPedidoSinMarcar') AND TYPE = 'U')
   DROP TABLE LogCargaPedidoSinMarcar
GO

CREATE TABLE [dbo].[LogCargaPedidoSinMarcar](
	[IdRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[Campaniaid] [int] NOT NULL,
	[NroLote] [int] NOT NULL,
	[PedidoID] [int] NULL,
	[Origen] [char](1) NULL,
	[Cantidad] [int] NULL,
	[CodigoUsuarioProceso] [varchar](25) NOT NULL,
	[FechaCarga] [datetime] NULL,
	[VersionProl] [tinyint] NULL,
	[IPUsuario] [nvarchar](2000) NULL,
	[TipoCupon] [nvarchar](2000) NULL,
	[ValorCupon] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LogCargaPedidoSinMarcar] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]

GO













