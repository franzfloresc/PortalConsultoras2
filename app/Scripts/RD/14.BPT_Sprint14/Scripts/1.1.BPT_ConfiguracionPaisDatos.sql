
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionPaisDatos]') AND type in (N'U'))
	DROP TABLE [dbo].[ConfiguracionPaisDatos]
GO

CREATE TABLE [dbo].[ConfiguracionPaisDatos](
	[ConfiguracionPaisID] [int] NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
	[CampaniaID] [int] NOT NULL,
	[Valor1] [varchar](800) NULL,
	[Valor2] [varchar](800) NULL,
	[Valor3] [varchar](800) NULL,
	[Descripcion] [varchar](800) NULL,
	[Estado] [bit] NOT NULL,
)
GO
