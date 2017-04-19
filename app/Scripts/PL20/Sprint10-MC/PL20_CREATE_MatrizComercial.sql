USE [BelcorpCostaRica]
GO

/****** Object:  Table [dbo].[MatrizComercial]    Script Date: 19/04/2017 10:53:28 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MatrizComercialTemp](
	[IdMatrizComercial] [int] IDENTITY(1,1) NOT NULL,
	[CodigoSAP] [varchar](50) NULL,
	[DescripcionOriginal] [varchar](250) NULL,
	[Descripcion] [varchar](250) NULL,
	[UsuarioRegistro] [varchar](50) NULL,
	[FechaRegistro] [datetime] NULL,
	[UsuarioModificacion] [varchar](50) NULL,
	[FechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMatrizComercial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


