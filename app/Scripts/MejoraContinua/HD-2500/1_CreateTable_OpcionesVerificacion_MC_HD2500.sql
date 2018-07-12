USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'FiltrosOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[FiltrosOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'ZonasOpcionesVerificacion')
BEGIN
	DROP TABLE [dbo].[ZonasOpcionesVerificacion]
END
GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'OpcionesVerificacion') 
BEGIN
	DROP TABLE [dbo].[OpcionesVerificacion]
END
GO
CREATE TABLE [dbo].[OpcionesVerificacion](
	[OrigenID][int] NOT NULL,
	[OrigenDescripcion][varchar](40) NOT NULL,
	[OpcionEmail][bit] NULL,
	[OpcionSms][bit] NULL,
	[OpcionChat][bit] NULL,
	[OpcionBelcorpResponde][bit] NULL,
	[IncluyeFiltros][bit] NULL,
	[TieneZonas][bit] NULL,
	[Activo][bit] NULL,
 CONSTRAINT [PK_OpcionVerificacion_OrigenID] PRIMARY KEY CLUSTERED 
(
	[OrigenID] ASC
)) 
GO
CREATE TABLE [dbo].[ZonasOpcionesVerificacion](
[RegionID] [int] NOT NULL,
	[ZonaID] [int] NOT NULL,
	[OlvideContrasenya] [bit] NULL,
	[VerifAutenticidad] [bit] NULL,
	[ActualizarDatos] [bit] NULL,
	[CDR] [bit] NULL,
 CONSTRAINT [PK_ZonasOpcionesVerificacion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC,
	[ZonaID] ASC
)) 

GO

CREATE TABLE [dbo].[FiltrosOpcionesVerificacion](
	[FiltrosID] [int] IDENTITY(1,1) NOT NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFinal] [int] NULL,
	[MensajeSaludo] [varchar](500) NULL,
	[Activo] [bit] NULL,
	[OrigenID] [int] NOT NULL,
 CONSTRAINT [PK_FiltrosOpcionesVerificacion_FiltrosID] PRIMARY KEY CLUSTERED 
(
	[FiltrosID] ASC
))

GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion]  WITH CHECK ADD  CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion] FOREIGN KEY([OrigenID])
REFERENCES [dbo].[OpcionesVerificacion] ([OrigenID])
GO
ALTER TABLE [dbo].[FiltrosOpcionesVerificacion] CHECK CONSTRAINT [FK_FiltrosOpcionesVerificacion_OpcionesVerificacion]
GO

