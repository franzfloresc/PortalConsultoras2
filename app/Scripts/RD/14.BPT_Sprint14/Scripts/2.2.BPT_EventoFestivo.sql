USE BelcorpPeru_BPT
GO

IF EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
)
BEGIN
	PRINT('Eliminando evento festivo : GIF_MENU_OFERTAS_BPT')
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
END

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_GANA_MAS'
)
BEGIN
	PRINT('Creando Evento Festivo : GIF_MENU_OFERTAS_BPT_GANA_MAS')
	INSERT INTO EventoFestivo(
	Nombre
	,Alcance
	,Periodo
	,Inicio
	,Fin
	,Personalizacion
	,Estado
	)
	VALUES(
	'GIF_MENU_OFERTAS_BPT_GANA_MAS'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-ganamas-navidad.gif'
	,1
	)
END

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
)
BEGIN
	PRINT('Creando Evento Festivo : GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
	INSERT INTO EventoFestivo(
	Nombre
	,Alcance
	,Periodo
	,Inicio
	,Fin
	,Personalizacion
	,Estado
	)
	VALUES(
	'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/EventoFestivo/PE/gif-clubganamas-navidad.gif'
	,1
	)
END