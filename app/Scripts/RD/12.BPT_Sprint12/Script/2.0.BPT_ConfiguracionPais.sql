
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 1,
		1, 201715,
		0, 0, 0, 0,
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
end
GO
