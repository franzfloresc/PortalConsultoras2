
Use BelcorpCostaRica

go

update ConfiguracionPais
set Estado = 0
, Excluyente = 1
where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD')

go
