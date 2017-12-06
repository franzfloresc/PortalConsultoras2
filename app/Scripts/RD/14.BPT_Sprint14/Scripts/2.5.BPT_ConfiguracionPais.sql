
Use BelcorpCostaRica

go
DECLARE @PaisIso char(2) = '  '

select @PaisIso = CodigoISO
from pais where EstadoActivo = 1

update ConfiguracionPais
set Estado = 1
, Excluyente = 1
where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD')

go
