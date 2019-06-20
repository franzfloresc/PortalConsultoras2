
go

update d
set d.Valor1 = isnull(d.Valor1, '') + ',004'
from ConfiguracionPaisDatos d
inner join configuracionpais p on p.configuracionpaisid = d.configuracionpaisid
where p.codigo = 'MSPersonalizacion'
and d.codigo = 'EstrategiaDisponible'

go
