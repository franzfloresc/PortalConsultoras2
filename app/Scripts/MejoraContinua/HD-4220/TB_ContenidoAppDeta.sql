USE [BelcorpPeru_MC]
GO
/****** Object:  Table [dbo].[ContenidoAppDeta]    Script Date: 22/5/2019 09:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContenidoAppDeta](
	[IdContenidoDeta] [int] IDENTITY(1,1) NOT NULL,
	[IdContenido] [int] NULL,
	[CodigoDetalle] [varchar](150) NULL,
	[Descripcion] [varchar](250) NULL,
	[RutaContenido] [varchar](250) NULL,
	[Accion] [varchar](20) NULL,
	[Orden] [int] NULL,
	[Estado] [bit] NULL,
	[Tipo] [varchar](25) NULL,
	[Campania] [int] NULL,
	[Region] [varchar](50) NULL,
	[Zona] [varchar](max) NULL,
	[Seccion] [varchar](max) NULL,
 CONSTRAINT [PK_ContenidoAppDeta] PRIMARY KEY CLUSTERED 
(
	[IdContenidoDeta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]

GO
SET ANSI_PADDING OFF
GO
