USE BelcorpPeru
GO

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
		'RDI', 1, 'Revista Digital Intriga', 0,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpMexico
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpColombia
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpVenezuela
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpSalvador
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpPuertoRico
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpPanama
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpGuatemala
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpEcuador
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpDominicana
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpCostaRica
GO

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
		'RDI', 1, 'Revista Digital Intriga', 0,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpChile
GO

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
		'RDI', 1, 'Revista Digital Intriga', 0,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

USE BelcorpBolivia
GO

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
		'RDI', 1, 'Revista Digital Intriga', 1,
		0, 201804,
		(select max(Orden) + 1 from ConfiguracionPais), 
		(select max(MobileOrden) + 1 from ConfiguracionPais), 
		(select max(OrdenBpt) + 1 from ConfiguracionPais), 
		(select max(MobileOrdenBPT) + 1 from ConfiguracionPais), 
		null, null,
		null, null,
		null, null,
		null, null,
		null, null,
		null, null)
END
GO

