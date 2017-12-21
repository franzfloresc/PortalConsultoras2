USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END

CREATE TABLE [dbo].[CodigoSMS](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoConsultora] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

