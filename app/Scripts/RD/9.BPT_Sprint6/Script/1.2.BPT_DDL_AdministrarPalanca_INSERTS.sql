USE BelcorpPeru
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpMexico
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpColombia
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpVenezuela
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201711,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201711,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201711,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201711,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201711,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201711,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201711,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201711,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201711,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201711,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201711,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201711,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201711,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpSalvador
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpPuertoRico
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpPanama
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpGuatemala
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpEcuador
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpDominicana
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpCostaRica
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpChile
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go

USE BelcorpBolivia
GO

if exists (select 1 from ConfiguracionPais where Codigo = 'RDS')
begin
	update ConfiguracionPais set
		Tieneperfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'RDS'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RDR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para mí',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para mí',
		Orden = 5,
		DesktopFondoBanner = 'rdr-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rdr-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rdr-logo-epm-desktop.png',
		MobileLogoBanner = 'rdr-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Ofertas para MÍ',
		DesktopTituloMenu = '¡Aprovecha!|Ofertas para MÍ',
		Orden = 5,
		DesktopFondoBanner = 'rd-banner-epm-desktop.jpg',
		MobileFondoBanner = 'rd-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'rd-logo-epm-desktop.png',
		MobileLogoBanner = 'rd-logo-epm-mobile.png',
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RD'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFT')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFT'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OFTGM')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'OFTGM'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'CDR-EXP')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'CDR-EXP'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'AO')
begin
	update ConfiguracionPais set
		TienePerfil = 0,
		DesdeCampania = 0,
		Orden = 0,
		UrlMenu = null,
		OrdenBpt = 0
	where Codigo = 'AO'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'SR')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,		
		MobileTituloMenu = 'Navidad',
		DesktopTituloMenu = 'Ofertas|Especiales de Navidad',
		Orden = 1,
		DesktopFondoBanner = 'sr-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'sr-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'sr-logo-navidad-desktop.png',
		MobileLogoBanner = 'sr-logo-navidad-mobile.png',
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,
	DesktopTituloMenu,Orden,DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,	UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201714,'Navidad',
	'Ofertas|Especiales de Navidad',1,'sr-banner-navidad-desktop.jpg','sr-banner-navidad-mobile.jpg',
	'sr-logo-navidad-desktop.png','sr-logo-navidad-mobile.png','ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = '¡Solo Hoy!',
		DesktopTituloMenu = 'Ofertas|¡Solo Hoy!',
		Orden = 3,	
		DesktopTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		MobileTituloBanner = '#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
		DesktopSubTituloBanner = 'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN',
		MobileSubTituloBanner = 'Oferta sólo por hoy',
		DesktopFondoBanner = 'odd-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'odd-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'odd-logo-navidad-desktop.png',
		MobileLogoBanner = 'odd-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201714,'¡Solo Hoy!','Ofertas|¡Solo Hoy!',
	3,'#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!','#Nombre, LOS MÁS DESTACADOS ESTA NAVIDAD!',
	'ESTA NAVIDAD GANA MÁS CON LOS SETS QUE TODOS QUIEREN','Oferta sólo por hoy','odd-banner-navidad-desktop.jpg',
	'odd-banner-navidad-mobile.jpg','odd-logo-navidad-desktop.png','odd-logo-navidad-mobile.png','#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!',
		DesktopTituloMenu = 'Lanzamientos|Lo nuevo ¡Nuevo!',
		Orden = 3,
		DesktopTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		MobileTituloBanner = '#Nombre, Lo nuevo ¡nuevo!',
		DesktopSubTituloBanner = 'Productos recién llegados',
		MobileSubTituloBanner = 'No Aplica',
		DesktopFondoBanner = 'lan-banner-epm-desktop.jpg',
		MobileFondoBanner = 'lan-banner-epm-mobile.jpg',
		DesktopLogoBanner = 'lan-logo-epm-desktop.png',
		MobileLogoBanner = 'lan-logo-epm-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201714,'Lo nuevo ¡Nuevo!|Lo nuevo ¡Nuevo!','Lanzamientos|Lo nuevo ¡Nuevo!',
	3,'#Nombre, Lo nuevo ¡nuevo!','#Nombre, Lo nuevo ¡nuevo!','Productos recién llegados','No Aplica','lan-banner-epm-desktop.jpg',
	'lan-banner-epm-mobile.jpg','lan-logo-epm-desktop.png','lan-logo-epm-mobile.png','#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		DesktopTituloMenu = '|Inicio',
		Orden = 0,
		DesktopTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		MobileTituloBanner = '#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
		DesktopSubTituloBanner = 'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.',		
		DesktopFondoBanner = 'iniciord-banner-epm-desktop-default.png',
		MobileFondoBanner = 'iniciord-banner-epm-mobile-default.png',
		DesktopLogoBanner = 'iniciord-logo-epm-desktop.png',
		MobileLogoBanner = 'iniciord-logo-epm-mobile.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopSubTituloBanner,DesktopFondoBanner,
	MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',1,1,201714,'|Inicio',
	0,'#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!','#Nombre, ¡Haz crecer tu negocio con ÉSIKA PARA MÍ!',
	'Aprovecha las ofertas ¡Solo Hoy! y Los sets especialmente creados para ti.','iniciord-banner-epm-desktop-default.png',
	'iniciord-banner-epm-mobile-default.png','iniciord-logo-epm-desktop.png','iniciord-logo-epm-mobile.png','Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,	
		MobileTituloMenu = 'Ofertas para ti|No aplica',
		DesktopTituloMenu = 'Ofertas para #Nombre|Ofertas para ti',
		Orden = 2,
		DesktopTituloBanner = '#Nombre, empieza ganando esta campaña',
		MobileTituloBanner = '#Nombre, empieza ganando esta campaña',
		DesktopSubTituloBanner = 'Es tiempo de ganar más',
		MobileSubTituloBanner = 'No aplica',
		DesktopFondoBanner = 'opt-banner-navidad-desktop.jpg',
		MobileFondoBanner = 'opt-banner-navidad-mobile.jpg',
		DesktopLogoBanner = 'opt-logo-navidad-desktop.png',
		MobileLogoBanner = 'opt-logo-navidad-mobile.png',
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,DesktopSubTituloBanner,
	MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,
	MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201714,'Ofertas para ti|No aplica','Ofertas para #Nombre|Ofertas para ti',
	2,'#Nombre, empieza ganando esta campaña','#Nombre, empieza ganando esta campaña','Es tiempo de ganar más',
	'No aplica','opt-banner-navidad-desktop.jpg','opt-banner-navidad-mobile.jpg','opt-logo-navidad-desktop.png',
	'opt-logo-navidad-mobile.png','#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201714,
		MobileTituloMenu = 'Inicio',
		DesktopTituloMenu = '|Inicio',
		Orden = 0,		
		DesktopTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		MobileTituloBanner = '#Nombre, Todas tus ofertas en un solo lugar.',
		DesktopFondoBanner = 'inicio-banner-navidad-desktop-default.jpg',
		MobileFondoBanner = 'inicio-banner-navidad-mobile-default.jpg',
		DesktopLogoBanner = 'inicio-logo-navidad-desktop-default.png',
		MobileLogoBanner = 'inicio-logo-navidad-mobile-default.png',
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,
	Orden,DesktopTituloBanner,MobileTituloBanner,
	DesktopFondoBanner,MobileFondoBanner,
	DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201714,'Inicio','|Inicio',
	0,'#Nombre, Todas tus ofertas en un solo lugar.','#Nombre, Todas tus ofertas en un solo lugar.',
	'inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg',
	'inicio-logo-navidad-desktop-default.png','inicio-logo-navidad-mobile-default.png','Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,
	MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201714,1,1,'sr-fondo-desktop.png','sr-fondo-mobile.png','Ofertas especiales de navidad',
	'ShowRoom',5,5,null,null,0,0,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201714,3,3,'Oferta del día','Oferta del día',
	6,6,null,null,
	3,0,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201714,4,4,'Lo nuevo','Lo nuevo',
	0,0,'005','005',
	0,0,1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,
	DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201714,5,5,'rd-fondo-desktop.png','rd-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'001,007,008','001,007,008',
	3,0,1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201714,5,5,'rdr-fondo-desktop.png','rdr-fondo-mobile.png','MÁS OFERTAS PARA MI ','MÁS OFERTAS PARA MI ',
	0,0,'002,002,002,001,007,008,002','001,007,008',3,0,
	1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,
	DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,
	DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201714,2,2,'opt-fondo-desktop.png',null,'¡Aprovecha!','MÁS OFERTAS PARA Mí',
	0,0,'001','001',3,0,
	1,1,null,99,99)
end

go