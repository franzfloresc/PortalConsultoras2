USE BelcorpChile_BPT
GO

IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN

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
		'RDI', 0, 'Revista Digital Intriga', 1,
		1, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		'', '',
		'', '',
		'', '',
		'', '',
		'', '',
		'', null)

	update ConfiguracionPais
	set 
	Estado = 0
	where Codigo = 'RD'
END
GO