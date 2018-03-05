use BelcorpChile_bpt
go

print db_name()

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'INICIORD'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : INICIORD'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con Gana+!'
	,cp.DesktopSubTituloBanner = '#Nombre, ¡Haz crecer tu negocio con Gana+!'
	,cp.MobileTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.'
	,cp.MobileSubTituloBanner = NULL
	,DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png'
	,MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png'
	,DesktopLogoBanner = NULL
	,MobileLogoBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'INICIORD'
end

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'SR'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : SR'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, más opciones de regalo para ti y tus clientes'
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = '#Nombre, más opciones de regalo para ti y tus clientes'
	,cp.MobileSubTituloBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'SR'
end

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'RD'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : RD'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar!'
	,cp.DesktopSubTituloBanner = NULL
	,cp.MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar!'
	,cp.MobileSubTituloBanner = NULL
	,DesktopFondoBanner = 'rd-banner-epm-desktop.jpg'
	,MobileFondoBanner = 'rd-banner-epm-mobile.jpg'
	,DesktopLogoBanner = NULL
	,MobileLogoBanner = NULL
	from ConfiguracionPais cp
	where cp.Codigo = 'RD'
end