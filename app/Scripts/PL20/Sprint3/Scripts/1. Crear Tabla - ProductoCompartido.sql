USE [BelcorpBolivia]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpChile]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpColombia]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpCostaRica]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpDominicana]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpEcuador]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpGuatemala]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpMexico]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpPanama]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpPeru]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpPuertoRico]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpSalvador]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/*end*/

USE [BelcorpVenezuela]
GO

/****** Object:  Table [dbo].[ProductoCompartido]    Script Date: 06/01/2017 16:48:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.ProductoCompartido')
BEGIN
  DROP TABLE dbo.ProductoCompartido
END

GO

CREATE TABLE [dbo].[ProductoCompartido](
	[ProductoCompID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Palanca] [varchar](10) NULL,
	[Detalle] [varchar](max) NULL,
	[Applicacion] [varchar](5) NULL,
	[FechaRegisto] [datetime] NULL,
 CONSTRAINT [PK_ProductoCompartido] PRIMARY KEY CLUSTERED 
(
	[ProductoCompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

