use BelcorpPeru_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas2.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado2.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'Conoce Gana+'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco2.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios de gana+'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'Pj_whuH1j7E'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMas.pdf'
declare @UrlPreguntasFrecuentes_Valor2 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMasNuevas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Terminos_y_Condiciones-GanaMas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'menuOfertas.jpg'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'menuOfertas.jpg'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Actualizando ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Actualizando ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Actualizando ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Actualizando ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Actualizando ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Actualizando ''Actualizando'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

print  'Actualizando ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 =@UrlPreguntasFrecuentes_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Actualizando ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Actualizando ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Actualizando ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo

go

use BelcorpChile_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas2.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado2.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'Conoce Gana+'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco2.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios de gana+'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'Pj_whuH1j7E'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMas.pdf'
declare @UrlPreguntasFrecuentes_Valor2 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMasNuevas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CL/Terminos_y_Condiciones-GanaMas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'menuOfertas.jpg'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'menuOfertas.jpg'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Actualizando ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Actualizando ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Actualizando ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Actualizando ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Actualizando ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Actualizando ''Actualizando'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

print  'Actualizando ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 =@UrlPreguntasFrecuentes_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Actualizando ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Actualizando ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Actualizando ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo

go

use BelcorpCostaRica_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @RevistaDigitalIntriga_Codigo varchar(50) = 'RDI'
--
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'
--
declare @LogoMenuOfertasActiva_Codigo varchar(50) = 'LogoMenuOfertasActiva'
declare @LogoMenuOfertasActiva_Valor1 varchar(800) = 'gif-club-ganamas2.gif'
--
declare @PopupImagenEtiqueta_Codigo varchar(50) = 'PopupImagenEtiqueta'
declare @PopupImagenEtiqueta_Valor1 varchar(800) = 'ClubGanaMas-etiqueta-dorado2.png'
--
declare @PopupBotonTexto_Codigo varchar(50) = 'PopupBotonTexto'
declare @PopupBotonTexto_Valor1 varchar(800) = 'Conoce Gana+'
--
declare @LogoComercialActiva_Codigo varchar(50) = 'LogoComercialActiva'
declare @LogoComercialActiva_Valor1 varchar(800) = 'logotipo-club-ganamaplus-blanco2.svg'
--
declare @PopupBloqueadoNS_Codigo varchar(50) = 'PopupBloqueadoNS'
declare @PopupBloqueadoNS_Valor2 varchar(800) = 'ESTE Y OTROS PRODUCTOS SOLO EN GANA+'
--
declare @PopupBloqueadoSNA_Codigo varchar(50) = 'PopupBloqueadoSNA'
declare @PopupBloqueadoSNA_Valor2 varchar(800) = 'los beneficios de gana+'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'Pj_whuH1j7E'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMas.pdf'
declare @UrlPreguntasFrecuentes_Valor2 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/PE/Preguntas_Frecuentes-GanaMasNuevas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'https://somosbelcorpqa.s3.amazonaws.com/FileConsultoras/CR/Terminos_y_Condiciones-GanaMas.pdf'
--
declare @LogoMenuOfertasNoActiva_Codigo varchar(50) = 'LogoMenuOfertasNoActiva'
declare @LogoMenuOfertasNoActiva_Valor1 varchar(800) = 'menuOfertas.jpg'
--
declare @LogoMenuOfertas_Codigo varchar(50) = 'LogoMenuOfertas'
declare @LogoMenuOfertas_Valor1 varchar(800) = 'menuOfertas.jpg'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Actualizando ''LogoMenuOfertasActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasActiva_Codigo

print  'Actualizando ''PopupImagenEtiqueta'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupImagenEtiqueta_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupImagenEtiqueta_Codigo

print  'Actualizando ''PopupBotonTexto'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @PopupBotonTexto_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBotonTexto_Codigo

print  'Actualizando ''LogoComercialActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialActiva_Valor1,
	cpd.Valor2 =@LogoComercialActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialActiva_Codigo

print  'Actualizando ''PopupBloqueadoNS'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoNS_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoNS_Codigo

print  'Actualizando ''Actualizando'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor2 = @PopupBloqueadoSNA_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @PopupBloqueadoSNA_Codigo

print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

print  'Actualizando ''UrlPreguntasFrecuentes'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlPreguntasFrecuentes_Valor1,
	cpd.Valor2 =@UrlPreguntasFrecuentes_Valor2
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlPreguntasFrecuentes_Codigo

print  'Actualizando ''UrlTerminosCondiciones'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @UrlTerminosCondiciones_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @UrlTerminosCondiciones_Codigo

print  'Actualizando ''LogoMenuOfertasNoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertasNoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoMenuOfertasNoActiva_Codigo

print  'Actualizando ''LogoMenuOfertas'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoMenuOfertas_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigitalIntriga_Codigo
and cpd.Codigo = @LogoMenuOfertas_Codigo

go

--use BelcorpColombia_BPT
--go

--print  'BD : ' + db_name()

--declare @RevistaDigital_Codigo varchar(50) = 'RD'
--declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
--declare @InformativoVideo_Valor1 varchar(800) = 'NMule6rKb9g'

--print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

--update cpd
--set cpd.Valor1 = @InformativoVideo_Valor1,
--	cpd.Valor2 =@InformativoVideo_Valor1
--from ConfiguracionPais cp
--	join ConfiguracionPaisDatos cpd 
--		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
--where cp.codigo = @RevistaDigital_Codigo
--and cpd.Codigo = @InformativoVideo_Codigo
--go