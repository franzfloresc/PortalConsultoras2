USE BelcorpPeru
GO

go

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

USE BelcorpMexico
GO

go

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

USE BelcorpColombia
GO

go

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

USE BelcorpVenezuela
GO

go

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

USE BelcorpSalvador
GO

go

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

USE BelcorpPuertoRico
GO

go

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

USE BelcorpPanama
GO

go

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

USE BelcorpGuatemala
GO

go

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

USE BelcorpEcuador
GO

go

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

USE BelcorpDominicana
GO

go

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

USE BelcorpCostaRica
GO

go

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

USE BelcorpChile
GO

go

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

USE BelcorpBolivia
GO

go

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
