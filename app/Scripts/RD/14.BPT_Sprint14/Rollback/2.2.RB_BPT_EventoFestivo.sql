USE BelcorpPeru_BPT
GO

PRINT('ROLLBACK')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
)
BEGIN
	PRINT('Insertando evento festivo : GIF_MENU_OFERTAS_BPT')
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/PE/gif-navidad-es-novedad.gif'
	,1
	)
END

IF EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_GANA_MAS'
)
BEGIN
	PRINT('Eliminando Evento Festivo : GIF_MENU_OFERTAS_BPT_GANA_MAS')
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_GANA_MAS'
END

IF EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
)
BEGIN
	PRINT('ELiminando Evento Festivo : GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END