
USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO

/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'UsuarioPostulante')
BEGIN
  DROP TABLE dbo.UsuarioPostulante
END
GO

CREATE TABLE [dbo].[UsuarioPostulante]
(
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CodigoUsuario] [varchar](20) NULL,
	[Zona] [varchar](4) NOT NULL,
	[Seccion] [char](1) NOT NULL,
	[EnvioCorreo] [char](1) NULL,
	[UsuarioReal] [char](1) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estado] [tinyint] NOT NULL
)
GO
