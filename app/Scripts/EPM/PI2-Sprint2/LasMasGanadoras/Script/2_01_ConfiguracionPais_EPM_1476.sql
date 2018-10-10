use [BelcorpPeru_BPT];
go

begin
	update 
		dbo.configuracionpais 
	set 
		 orden			= orden			 + 1
		,ordenbpt		= ordenbpt		 + 1
		,mobileorden	= mobileorden	 + 1
		,mobileordenbpt = mobileordenbpt + 1
	where 
		not orden in(0,1);

	-- inserta configuracionpais
	insert into dbo.configuracionpais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Orden,DesktopTituloBanner,MobileTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT) values
	('MG','1','MG - Descripcion','1','1','201800','LAS MÁS GANADORAS','LAS MÁS GANADORAS','2','MG - DesktopTituloBanner','MG - MobileTituloBanner','MG - MobileSubTituloBanner','inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg','logo-ganamas-desktop.png','logo-ganamas-mobile.png','HerramientaVenta/Index','2','2','2');
end;

use [BelcorpChile_BPT];
go

begin
	update 
		dbo.configuracionpais 
	set 
		 orden			= orden			 + 1
		,ordenbpt		= ordenbpt		 + 1
		,mobileorden	= mobileorden	 + 1
		,mobileordenbpt = mobileordenbpt + 1
	where 
		not orden in(0,1);

	-- inserta configuracionpais
	insert into dbo.configuracionpais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Orden,DesktopTituloBanner,MobileTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT) values
	('MG','1','MG - Descripcion','1','1','201800','LAS MÁS GANADORAS','LAS MÁS GANADORAS','2','MG - DesktopTituloBanner','MG - MobileTituloBanner','MG - MobileSubTituloBanner','inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg','logo-ganamas-desktop.png','logo-ganamas-mobile.png','HerramientaVenta/Index','2','2','2');
end;

use [BelcorpCostaRica_BPT];
go

begin
	update 
		dbo.configuracionpais 
	set 
		 orden			= orden			 + 1
		,ordenbpt		= ordenbpt		 + 1
		,mobileorden	= mobileorden	 + 1
		,mobileordenbpt = mobileordenbpt + 1
	where 
		not orden in(0,1);

	-- inserta configuracionpais
	insert into dbo.configuracionpais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,MobileTituloMenu,DesktopTituloMenu,Orden,DesktopTituloBanner,MobileTituloBanner,MobileSubTituloBanner,DesktopFondoBanner,MobileFondoBanner,DesktopLogoBanner,MobileLogoBanner,UrlMenu,OrdenBpt,MobileOrden,MobileOrdenBPT) values
	('MG','1','MG - Descripcion','1','1','201800','LAS MÁS GANADORAS','LAS MÁS GANADORAS','2','MG - DesktopTituloBanner','MG - MobileTituloBanner','MG - MobileSubTituloBanner','inicio-banner-navidad-desktop-default.jpg','inicio-banner-navidad-mobile-default.jpg','logo-ganamas-desktop.png','logo-ganamas-mobile.png','HerramientaVenta/Index','2','2','2');
end;