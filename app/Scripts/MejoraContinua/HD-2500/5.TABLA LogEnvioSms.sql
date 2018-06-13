USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
GO
CREATE TABLE [dbo].[LogEnvioSMS](
	[EnvioSmsID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[CodigoUsuario] [varchar](20) NOT NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[OrigenDescripcion] [varchar](50) NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[CampaniaID] [varchar](6) NULL,
	[Celular] [varchar](18),
	[MensajeEnviado] [varchar](200) NULL,
	[CodigoRespuesta] [varchar](15) NULL,
	[MensajeRespuesta] [varchar](200) NULL,
	[EsMobile] [bit] NULL,
	[FechaEnvio] [datetime] NULL,
 CONSTRAINT [PK__LogEnvio__F197DF2DABC122DD] PRIMARY KEY CLUSTERED 
(
	[EnvioSmsID] ASC,
	[OrigenID] ASC,
	[CodigoUsuario] ASC
))
GO

