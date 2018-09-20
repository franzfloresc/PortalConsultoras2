use BelcorpPeru_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'Ajoq2mlOliw'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/PE/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/PE/Terminos_y_condiciones_club_gana_mas.pdf'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

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

go

use BelcorpChile_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'ryVnFoi4VtM'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/CL/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/CL/Terminos_y_condiciones_club_gana_mas.pdf'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo


print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

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

go

use BelcorpCostaRica_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'rDg0pqMxwuY'
declare @UrlPreguntasFrecuentes_Codigo varchar(50) = 'UrlPreguntasFrecuentes'
declare @UrlPreguntasFrecuentes_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/CR/Preguntas_Frecuentes_club_gana_mas.pdf'
declare @UrlTerminosCondiciones_Codigo varchar(50) = 'UrlTerminosCondiciones'
declare @UrlTerminosCondiciones_Valor1 varchar(800) = 'http://cdn1-prd.somosbelcorp.com/FileConsultoras/CR/Terminos_y_condiciones_club_gana_mas.pdf'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

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


go


--use BelcorpColombia_BPT
--go

--print  'BD : ' + db_name()

--declare @RevistaDigital_Codigo varchar(50) = 'RD'
--declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
--declare @InformativoVideo_Valor1 varchar(800) = 'NMule6rKb9g'

--print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''
--select * from dbo.ConfiguracionPaisDatos where Codigo = 'InformativoVideo';
--update cpd
--set cpd.Valor1 = @InformativoVideo_Valor1,
--	cpd.Valor2 =@InformativoVideo_Valor1
--from ConfiguracionPais cp
--	join ConfiguracionPaisDatos cpd 
--		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
--where cp.codigo = @RevistaDigital_Codigo
--and cpd.Codigo = @InformativoVideo_Codigo
--go