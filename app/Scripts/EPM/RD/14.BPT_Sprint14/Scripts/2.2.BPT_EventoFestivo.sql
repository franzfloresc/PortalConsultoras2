USE BelcorpPeru
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo')

GO

USE BelcorpMexico
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpColombia
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpVenezuela
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpSalvador
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpPuertoRico
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpPanama
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpGuatemala
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpEcuador
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpDominicana
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

USE BelcorpCostaRica
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo')
GO

USE BelcorpChile
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo')
GO

USE BelcorpBolivia
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

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON OFERTAS GANA+' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'Aprovecha la oferta "solo hoy", sets especiales y mucho más.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'
UPDATE EventoFestivo SET Personalizacion = '' WHERE Nombre in ('RD_SI_D_ImagenLogo', 'RD_SI_M_ImagenLogo', 'RD_NO_D_ImagenLogo', 'RD_NO_M_ImagenLogo'
, 'RD_SI_D_ImagenFondo', 'RD_SI_M_ImagenFondo', 'RD_NO_D_ImagenFondo', 'RD_NO_M_ImagenFondo'
, 'GIF_MENU_OFERTAS_BPT_GANA_MAS', 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS')
GO

