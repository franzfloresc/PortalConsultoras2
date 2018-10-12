USE BelcorpPeru
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpMexico
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpColombia
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpSalvador
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpPuertoRico
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpPanama
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpGuatemala
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpEcuador
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpDominicana
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpCostaRica
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpChile
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

USE BelcorpBolivia
GO

/* MetaConsultora */
IF OBJECT_ID('[dbo].[MetaConsultora]', 'U') IS NOT NULL
	DROP TABLE [dbo].[MetaConsultora]
GO

CREATE TABLE [dbo].[MetaConsultora](
	[IdMetaConsultora] [bigint] IDENTITY(1,1) NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoMeta] [varchar](20) NOT NULL,
	[ValorMeta] [varchar](256) NULL,
	[FechaRegistro] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
    CONSTRAINT [PK_MetaConsultora_IdMetaConsultora] PRIMARY KEY CLUSTERED ( [IdMetaConsultora] ASC ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED	INDEX [UQ_MetaConsultora_CodigoUsuario_CodigoMeta] ON [dbo].[MetaConsultora]( [CodigoUsuario] ASC, [CodigoMeta] ASC ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetaConsultora] ADD  CONSTRAINT [DF_MetaConsultora_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO

