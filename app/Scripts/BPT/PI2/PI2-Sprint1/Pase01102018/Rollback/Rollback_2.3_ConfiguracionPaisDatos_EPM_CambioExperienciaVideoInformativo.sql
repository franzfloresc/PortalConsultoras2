use BelcorpPeru
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'Ajoq2mlOliw'

print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

go

use BelcorpChile
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'ryVnFoi4VtM'

print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

go

use BelcorpCostaRica
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'rDg0pqMxwuY'

print  'Rollback ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo

go
use BelcorpColombia
go

print  'BD : ' + db_name()

declare @RevistaDigital_Codigo varchar(50) = 'RD'
declare @InformativoVideo_Codigo varchar(50) = 'InformativoVideo'
declare @InformativoVideo_Valor1 varchar(800) = 'NMule6rKb9g'

print  'Actualizando ''InformativoVideo'' en ''ConfiguracionPaisDatos'''

update cpd
set cpd.Valor1 = @InformativoVideo_Valor1,
	cpd.Valor2 =@InformativoVideo_Valor1
from ConfiguracionPais cp
	join ConfiguracionPaisDatos cpd 
		on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID 
where cp.codigo = @RevistaDigital_Codigo
and cpd.Codigo = @InformativoVideo_Codigo
go
