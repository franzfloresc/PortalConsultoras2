
Use BelcorpCostaRica

go

update ConfiguracionPais
set Estado = 0
, Excluyente = 0
where Codigo in ('RD', 'RDS')

go

update ConfiguracionPais
set Estado = 0
, Excluyente = 1
where Codigo in ('LAN', 'INICIORD')


go


Use BelcorpChile
go

insert into ConfiguracionPaisDetalle(ConfiguracionPaisID,CodigoRegion,Estado)
values((select ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDS'), '17', 1)

go

insert into ConfiguracionPaisDetalle(ConfiguracionPaisID,CodigoRegion,Estado)
values((select ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'), '17', 1)

go

update ConfiguracionPais
set Estado = 1
, Excluyente = 0
where Codigo in ('RD', 'RDS')

go

update ConfiguracionPais
set Estado = 1
, Excluyente = 1
where Codigo in ('LAN', 'INICIORD')


go

