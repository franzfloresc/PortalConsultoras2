GO
USE BelcorpPeru
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpMexico
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpColombia
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpSalvador
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpPuertoRico
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpPanama
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpGuatemala
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpEcuador
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpDominicana
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpCostaRica
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpChile
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
USE BelcorpBolivia
GO

print  'BD : ' + db_name()

declare @PaisIso varchar(10) = ''
select @PaisIso = CodigoISO from Pais where estadoActivo = 1

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'CONOCE EL CLUB'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN CLUB GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios del club gana+'

declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/'+@PaisIso+'/Terminos_y_condiciones_club_gana_mas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'gifofertasdigitales.gif'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'gifofertasdigitales.gif'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Rollback ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Rollback ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Rollback ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Rollback ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Rollback ''PopupBloqueadoSNA'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Rollback ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 = ''
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Rollback ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Rollback ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Rollback ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo


GO
