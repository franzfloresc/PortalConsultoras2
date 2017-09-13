USE BelcorpBolivia
go

USE BelcorpChile_BPT
go

USE BelcorpColombia
go

USE BelcorpCostaRica
go

USE BelcorpDominicana
go

USE BelcorpEcuador
go

USE BelcorpGuatemala
go

USE BelcorpMexico
go

USE BelcorpPanama
go

USE BelcorpPeru_BPT
go

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
BEGIN
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
END
GO

SET IDENTITY_INSERT [dbo].[EventoFestivo] ON 

INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (1, N'FONDO_ESIKA', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/ESLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (2, N'FONDO_LBEL', N'LOGIN', N'1', N'20171023', N'20180114', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/LBLOGNAV_2017.jpg', 1)
INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (3, N'SALUDO', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'Feliz Navidad', 1)
INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (4, N'FONDO_INGPED', N'SOMOS_BELCORP', N'2', N'201717', N'201718', N'https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/INGPEDNAV_2017.png', 1)
INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (5, N'GIF_MENU_OFERTAS', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-navidad-es-novedad.gif', 1)
INSERT [dbo].[EventoFestivo] ([ID], [Nombre], [Alcance], [Periodo], [Inicio], [Fin], [Personalizacion], [Estado]) VALUES (6, N'GIF_MENU_OFERTAS_BPT', N'MENU_SOMOS_BELCORP', N'2', N'201714', N'201718', N'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-navidad-esikaparami.gif', 1)

SET IDENTITY_INSERT [dbo].[EventoFestivo] OFF
GO

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END
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
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND GETDATE() BETWEEN CONVERT(DATETIME, a.Inicio, 103) AND CONVERT(DATETIME, a.Fin, 103)
	AND Estado = 1
END
IF(@Alcance = 'SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

IF (@Alcance = 'MENU_SOMOS_BELCORP')
BEGIN
	SELECT Nombre, Personalizacion 
	FROM [dbo].[EventoFestivo] a 
	WHERE Alcance = @Alcance 
	AND @Campania BETWEEN Inicio AND Fin
	AND Estado = 1
END

END
GO

USE BelcorpPuertoRico
go

USE BelcorpSalvador
go

USE BelcorpVenezuela
go