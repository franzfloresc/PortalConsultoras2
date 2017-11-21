USE BelcorpPeru_BPT
GO

IF EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
AND ESTADO = 1
)
BEGIN
	PRINT('Cambiando estado a ''0'' evento festivo : GIF_MENU_OFERTAS_BPT')
	UPDATE EventoFestivo
	SET ESTADO = 0
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
	,'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/PE/gif-navidad-bpt-ganamas.gif'
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
	,'https://s3.amazonaws.com/consultorasPRD/SomosBelcorp/EventoFestivo/PE/gif-navidad-bpt-clubganamas.gif'
	,1
	)
END