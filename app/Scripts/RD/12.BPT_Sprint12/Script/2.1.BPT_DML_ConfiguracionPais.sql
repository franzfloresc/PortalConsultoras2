
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
		'Guía de Negocio Digitalizada', 'Guía de Negocio Digitalizada',
		'', '',
		'sr-banner-navidad-desktop.jpg', 'sr-banner-navidad-mobile.jpg',
		'sr-logo-navidad-desktop.png', 'sr-logo-navidad-mobile.png',
		'GuiaNegocio', null)
end
GO
