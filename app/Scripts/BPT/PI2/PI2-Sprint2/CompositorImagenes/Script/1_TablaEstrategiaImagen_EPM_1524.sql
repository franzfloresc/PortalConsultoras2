--USE [BelcorpPeru_BPT]
--GO

--USE [BelcorpChile_BPT]
--GO

USE [BelcorpCostaRica_BPT]
GO

/****** Object:  Table [dbo].[EstrategiaImagen]    Script Date: 24/10/2018 12:15:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF OBJECT_ID('dbo.EstrategiaImagen', 'U') IS NOT NULL 
  DROP TABLE dbo.EstrategiaImagen; 

CREATE TABLE [dbo].[EstrategiaImagen](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CampaniaID] [int] NOT NULL,
	[CUV] [varchar](20) NULL,
	[NombreImagen] [varchar](800) NULL,
	[Fecha] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [DATA]

GO

SET ANSI_PADDING OFF
GO


