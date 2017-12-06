USE BelcorpPeru
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpMexico
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpColombia
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpVenezuela
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpSalvador
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpPuertoRico
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpPanama
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpGuatemala
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpEcuador
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpDominicana
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpCostaRica
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpChile
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

USE BelcorpBolivia
GO

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
GO

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
GO

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
GO 

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
GO

