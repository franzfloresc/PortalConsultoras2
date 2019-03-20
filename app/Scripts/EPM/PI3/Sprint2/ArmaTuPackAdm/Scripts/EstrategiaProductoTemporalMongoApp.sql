USE BelcorpPeru_BPT

--USE BelcorpChile_BPT

--USE BelcorpCostaRica_BPT

GO

IF EXISTS (	SELECT 1
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'EstrategiaProductoTemporalMongoApp'
			AND SO.[TYPE] = 'U')

BEGIN
	DROP TABLE [EstrategiaProductoTemporalMongoApp]
END

GO


CREATE TABLE [dbo].[EstrategiaProductoTemporalMongoApp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsoPais] [varchar](5) NULL,
	[Campania] [int] NULL,
	[CodigoSap] [varchar](20) NULL,
	[NombreComercial] [varchar](max) NULL,
	[Descripcion] [varchar](max) NULL,
	[Volumen] [varchar](50) NULL,
	[Imagen] [varchar](200) NULL,
	[ImagenBulk] [varchar](200) NULL,
	[NombreBulk] [varchar](256) NULL,
	[CampaniaApp] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO
