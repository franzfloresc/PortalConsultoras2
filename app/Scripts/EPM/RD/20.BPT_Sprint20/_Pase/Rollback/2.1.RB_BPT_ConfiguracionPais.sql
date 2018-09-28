USE BelcorpPeru
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpMexico
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpColombia
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpSalvador
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpPuertoRico
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpPanama
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpGuatemala
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpEcuador
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpDominicana
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpCostaRica
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpChile
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

USE BelcorpBolivia
GO

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

if exists(	select 1
			from ConfiguracionPais cp
			where cp.Codigo = 'GND'	)
begin
	print 'Rollback Actualizando ConfiguracionPais : GND'
	update cp
	set 
	cp.DesktopTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.DesktopSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	,cp.MobileTituloBanner = '#Nombre, disfruta de tu guía de negocio online'
	,cp.MobileSubTituloBanner = 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.'
	from ConfiguracionPais cp
	where cp.Codigo = 'GND'
end

GO

