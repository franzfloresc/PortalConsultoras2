
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
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IsoPais] [varchar](5) NULL,
	[Campania] [int] NULL,
	[CodigoSap] [varchar](20) NULL,
	[NombreComercial] [varchar](max) NULL,
	[Descripcion] [varchar](max) NULL,
	[Volumen] [varchar](50) NULL,
	[Imagen] [varchar](200) NULL,
	[ImagenBulk] [varchar](200) NULL,
	[NombreBulk] [varchar](256) NULL,
	[CampaniaApp] [int] NULL
)

GO