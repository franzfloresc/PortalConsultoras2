USE BelcorpBolivia
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/BO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpChile
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CL/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpColombia
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpCostaRica
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, Es tiempo de ganar más', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/CR/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpDominicana
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/DO/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpEcuador
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/E /INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/EC/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpGuatemala
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/GT/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpMexico
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO


CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, Es tiempo de ganar más', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/MX/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpPanama
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, Es tiempo de ganar más', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PA/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpPeru
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpPuertoRico
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, Es tiempo de ganar más', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PR/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpSalvador
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/SV/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpVenezuela
go

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EventoFestivo]') AND (type = 'U') )
	DROP TABLE [dbo].EventoFestivo
GO

CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)

GO


INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/gif-navidad-esikaparami.gif', 1)

-- para RD
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'APROVECHAS LAS OFERTAS ¡SOLOS HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/logo-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/VE/banner-navidad-esikaparami.png', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'  ', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'Es tiempo de ganar más.', 1)
INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEventoFestivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEventoFestivo
GO

CREATE PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo 'MENU_SOMOS_BELCORP',201714
*/
BEGIN 

IF(@Alcance = 'LOGIN')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO