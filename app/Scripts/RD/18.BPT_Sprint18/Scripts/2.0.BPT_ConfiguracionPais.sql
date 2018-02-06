USE BelcorpPeru
GO

PRINT('BelcorpPeru')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Inactivo')
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
		'RDI', 0, 'Revista Digital Intriga', 0,
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpCostaRica
GO

PRINT('BelcorpCostaRica')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Inactivo')
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
		'RDI', 0, 'Revista Digital Intriga', 0,
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpChile
GO

PRINT('BelcorpChile')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Inactivo')
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
		'RDI', 0, 'Revista Digital Intriga', 0,
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpMexico
GO

PRINT('BelcorpMexico')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpColombia
GO

PRINT('BelcorpColombia')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpVenezuela
GO

PRINT('BelcorpVenezuela')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpSalvador
GO

PRINT('BelcorpSalvador')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpPuertoRico
GO

PRINT('BelcorpPuertoRico')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpPanama
GO

PRINT('BelcorpPanama')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpGuatemala
GO

PRINT('BelcorpGuatemala')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpEcuador
GO

PRINT('BelcorpEcuador')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpDominicana
GO

PRINT('BelcorpDominicana')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

USE BelcorpBolivia
GO

PRINT('BelcorpBolivia')
IF NOT EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	PRINT('insertando RDI en ConfiguracionPais con estado Activo')
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
		0, 201801,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,--'rdi-banner-epm-desktop.png', 'rdi-banner-epm-mobile.png',
		null, null,--'rdi-logo-epm-desktop.png', 'rdi-logo-epm-mobile.png',
		null, null)
END
GO

