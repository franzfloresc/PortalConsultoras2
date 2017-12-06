
GO

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')


IF EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
)
BEGIN
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
	,'http://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-ganamas-navidad.gif'
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
	,'http://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-clubganamas-navidad.gif'
	,1
	)
END

GO
