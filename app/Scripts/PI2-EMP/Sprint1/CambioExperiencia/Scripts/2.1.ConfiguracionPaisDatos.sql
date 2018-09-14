

use BelcorpPeru_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

go

use BelcorpChile_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

go

use BelcorpCostaRica_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'
declare @LogoComercialFondoActiva_Valor1 varchar(800) = 'logo-club-ganamas-dorado2.png'

print  'Actualizando ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @LogoComercialFondoActiva_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

go