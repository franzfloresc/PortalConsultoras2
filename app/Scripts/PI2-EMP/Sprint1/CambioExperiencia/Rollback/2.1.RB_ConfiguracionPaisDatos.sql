use BelcorpPeru_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
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

go

use BelcorpChile_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
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

go

use BelcorpCostaRica_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
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

go