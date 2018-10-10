USE BelcorpPeru
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpMexico
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpColombia
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpVenezuela
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpSalvador
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpPuertoRico
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpPanama
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpGuatemala
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpEcuador
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpDominicana
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpCostaRica
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpChile
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

USE BelcorpBolivia
GO

GO
declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

IF NOT EXISTS(
SELECT 1
FROM EventoFestivo
WHERE Nombre = 'GIF_MENU_OFERTAS_BPT'
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
	'GIF_MENU_OFERTAS_BPT'
	,'MENU_SOMOS_BELCORP'
	,'2'
	,'201716'
	,'201718'
	,'https://s3.amazonaws.com/consultoras' + @amb + '/SomosBelcorp/EventoFestivo/' + @codePais + '/gif-navidad-es-novedad.gif'
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
	DELETE
	FROM EventoFestivo
	WHERE Nombre = 'GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS'
END
GO 

declare @codePais varchar(5) = '', @amb varchar(5) = 'PRD'

select @codePais = CodigoIso
from Pais where EstadoActivo = '1'

set @codePais = isnull(@codePais, '')

UPDATE EventoFestivo SET Personalizacion = '#Nombre, IMPULSA TU CAMPAÑA NAVIDEÑA CON ÉSIKA PARA MÍ' WHERE Nombre = 'RD_SI_D_TituloBanner'
UPDATE EventoFestivo SET Personalizacion = 'APROVECHA LAS OFERTAS ¡SOLO HOY!. LOS SET ESPECIALES Y MUCHO MÁS!.' WHERE Nombre = 'RD_SI_D_SubTituloBanner'

UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-desktop.png' WHERE Nombre = 'RD_SI_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'https://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-epm-mobile.png' WHERE Nombre = 'RD_SI_M_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-desktop.png' WHERE Nombre = 'RD_NO_D_ImagenLogo'
UPDATE EventoFestivo SET Personalizacion = 'http://s3.amazonaws.com/consultoras'+@amb+'/SomosBelcorp/EventoFestivo/'+@codePais+'/logo-navidad-mobile.png' WHERE Nombre = 'RD_NO_M_ImagenLogo'
GO

