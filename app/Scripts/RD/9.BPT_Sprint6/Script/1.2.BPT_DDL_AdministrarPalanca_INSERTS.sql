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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201712,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201712,		
		Orden = 5,		
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
		DesdeCampania = 201712,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201712,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201712,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201712,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201712,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201712,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201712,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201712,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201712,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201712,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201712,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201712,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201712,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201712,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201712,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201712,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',1,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
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
		DesdeCampania = 201715,		
		Orden = 5,		
		UrlMenu = 'RevistaDigital/Comprar',
		OrdenBpt = 6
	where Codigo = 'RDR'
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'RD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 5,		
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
		DesdeCampania = 201715,		
		Orden = 1,		
		UrlMenu = 'ShowRoom',
		OrdenBpt = 2
	where Codigo = 'SR'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)	
	values ('SR',1,'ShowRoom',1,1,201715,1,'ShowRoom',2)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'ODD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,		
		UrlMenu = '#',
		OrdenBpt = 1
	where Codigo = 'ODD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('ODD',1,'Oferta del Día',1,1,201715,3,'#',1)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'LAN')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 3,
		UrlMenu = '#',
		OrdenBpt = 5
	where Codigo = 'LAN'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('LAN',1,'Lanzamientos',0,1,201715,3,'#',5)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIORD')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIORD'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIORD',1,'INICIO',0,1,201715,0,'Ofertas',0)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'OPT')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,		
		Orden = 2,		
		UrlMenu = '#',
		OrdenBpt = 3
	where Codigo = 'OPT'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('OPT',1,'Oferta Para Ti',1,1,201715,2,'#',3)
end

go

if exists (select 1 from ConfiguracionPais where Codigo = 'INICIO')
begin
	update ConfiguracionPais set
		TienePerfil = 1,
		DesdeCampania = 201715,
		Orden = 0,		
		UrlMenu = 'Ofertas',
		OrdenBpt = 0
	where Codigo = 'INICIO'
end
else
begin
	insert into ConfiguracionPais (Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,UrlMenu,OrdenBpt)
	values ('INICIO',1,'Inicio',1,1,201715,0,'Ofertas',0)
end

go

--	SR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'))
begin
	declare @ConfiguracionPaisID_SR int = 0
	select top 1 @ConfiguracionPaisID_SR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'SR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_SR,201715,1,1,null,null,1,1,null,2,2)
end

go

--	ODD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'))
begin
	declare @ConfiguracionPaisID_ODD int = 0
	select top 1 @ConfiguracionPaisID_ODD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'ODD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_ODD,201715,3,3,null,null,1,1,null,1,1)
end

go

--	LAN
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'))
begin
	declare @ConfiguracionPaisID_LAN int = 0
	select top 1 @ConfiguracionPaisID_LAN = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'LAN'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_LAN,201715,4,4,'005','005',1,1,null,3,3)
end

go

--	RD
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'))
begin
	declare @ConfiguracionPaisID_RD int = 0
	select top 1 @ConfiguracionPaisID_RD = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RD'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RD,201715,5,5,'001,007,008','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	RDR
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'))
begin
	declare @ConfiguracionPaisID_RDR int = 0
	select top 1 @ConfiguracionPaisID_RDR = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_RDR,201715,5,5,'002,002,002,001,007,008,002','001,007,008',1,1,'RevistaDigital/Comprar',99,99)
end

go

--	OPT
if not exists (select 1 from ConfiguracionOfertasHome where ConfiguracionPaisID in (
				select top 1 ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'))
begin
	declare @ConfiguracionPaisID_OPT int = 0
	select top 1 @ConfiguracionPaisID_OPT = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'OPT'

	insert into ConfiguracionOfertasHome 
	(ConfiguracionPaisiD,CampaniaID,DesktopOrden,MobileOrden,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT)
	values (@ConfiguracionPaisID_OPT,201715,2,2,'001','001',1,1,null,99,99)
end

go