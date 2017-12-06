
Use BelcorpCostaRica

go

update ConfiguracionPais
set Estado = 1
, Excluyente = 1
, DesktopFondoBanner = ''
, DesktopLogoBanner = ''
, MobileFondoBanner = ''
, MobileLogoBanner = ''
where Codigo in ('RD', 'RDS', 'LAN', 'INICIORD')

go
