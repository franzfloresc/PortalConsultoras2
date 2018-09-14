use BelcorpPeru_BPT
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @LogoComercialFondoActiva_Codigo varchar(50) = 'LogoComercialFondoActiva'

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
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

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
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

print  'Rollback ''LogoComercialFondoActiva'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = 'logo-club-ganamas-dorado.png'
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @LogoComercialFondoActiva_Codigo

go