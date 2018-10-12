USE BelcorpPeru
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpMexico
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, es tiempo de ganar más', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'LAS MEJORES OFERTAS SOLO AQUÍ.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpColombia
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpVenezuela
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201712', N'201712', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpSalvador
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpPuertoRico
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, es tiempo de ganar más', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'LAS MEJORES OFERTAS SOLO AQUÍ.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpPanama
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, es tiempo de ganar más', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'LAS MEJORES OFERTAS SOLO AQUÍ.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpGuatemala
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpEcuador
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpDominicana
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpCostaRica
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, es tiempo de ganar más', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'LAS MEJORES OFERTAS SOLO AQUÍ.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpChile
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

USE BelcorpBolivia
GO

GO

IF NOT EXISTS (SELECT * FROM EventoFestivo WHERE Alcance = 'MENU_SOMOS_BELCORP')
BEGIN

	declare @ispPais varchar(2) = ''
	select @ispPais = CodigoISO from pais where EstadoActivo = 1

	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-es-novedad.gif', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/gif-navidad-esikaparami.gif', 1)

	-- para RD
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-epm-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-epm-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, ¡GANA CON LAS OFERTAS DE NAVIDAD ES NOVEDAD!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_SI_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'  ', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-desktop.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-desktop.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'#Nombre, EMPIEZA GANANDO ESTA CAMPAÑA', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_D_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡GANA MÁS DESDE EL PRIMER DÍA CON TU GUÍA DE NEGOCIO ONLINE PERSONALIZADA!', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenLogo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/logo-navidad-mobile.png', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_ImagenFondo',		N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/'+ @ispPais + N'/banner-navidad-mobile.jpg', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_TituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'Es tiempo de ganar más.', 1)
	INSERT [dbo].[EventoFestivo] ([Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (N'RD_NO_M_SubTituloBanner',	N'MENU_SOMOS_BELCORP', N'2', N'201716', N'201718', N'¡LAS MEJORES OFERTAS SOLO AQUÍ!', 1)
END
GO

ALTER PROC [dbo].[GetEventoFestivo]
(
@Alcance varchar(30),
@Campania int = 0
)
AS
/*
GetEventoFestivo '',201717
*/
BEGIN 

	set @Alcance = isnull(@Alcance, '')

	SELECT a.Nombre, a.Alcance, a.Personalizacion, a.Periodo, a.Inicio, a.Fin
	FROM [dbo].[EventoFestivo] a with(nolock)
	WHERE a.Estado = 1
	AND  (
		(a.Periodo = 1 and (GETDATE()) BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103))
		or (a.Periodo = 2 and @Campania BETWEEN Inicio AND Fin)
	)
	AND (a.Alcance = @Alcance or @Alcance = '')
	 
END
GO

/* fin */

