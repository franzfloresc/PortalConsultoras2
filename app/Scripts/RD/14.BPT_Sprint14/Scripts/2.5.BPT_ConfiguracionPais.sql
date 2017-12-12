
Use BelcorpCostaRica

go


delete from ConfiguracionPaisDetalle 
where ConfiguracionPaisID in (select ConfiguracionPaisID from ConfiguracionPais where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD'))

update ConfiguracionPais
set Estado = 1
, Excluyente = 1
, DesktopFondoBanner = ''
, DesktopLogoBanner = ''
, MobileFondoBanner = ''
, MobileLogoBanner = ''
where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD')

go

Use BelcorpChile

go


delete from ConfiguracionPaisDetalle 
where ConfiguracionPaisID in (select ConfiguracionPaisID from ConfiguracionPais where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD'))

update ConfiguracionPais
set Estado = 1
, Excluyente = 1
, DesktopLogoBanner = ''
, MobileLogoBanner = ''
where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD')

go
