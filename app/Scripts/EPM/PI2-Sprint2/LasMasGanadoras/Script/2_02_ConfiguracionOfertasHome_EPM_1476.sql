use [BelcorpPeru_BPT];
go

begin
	declare @ConfiguracionPaisPeruID int;
	
	set @ConfiguracionPaisPeruID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBpt,DesktopUsarImagenFondo,MobileUsarImagenFondo) values 
	(@ConfiguracionPaisPeruID,'201801','2','2','PE_2018511276_bbymyqsrgu.png','herramientas-venta-mobile.jpg','LAS MÁS GANADORAS','LAS MÁS GANADORAS','1','1','007','007','5','5','1','1','HerramientasVenta/Comprar','2','2','0','0');
end;

use [BelcorpChile_BPT];
go

begin
	declare @ConfiguracionPaisChileID int;
	
	set @ConfiguracionPaisChileID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBpt,DesktopUsarImagenFondo,MobileUsarImagenFondo) values 
	(@ConfiguracionPaisChileID,'201801','2','2','PE_2018511276_bbymyqsrgu.png','herramientas-venta-mobile.jpg','LAS MÁS GANADORAS','LAS MÁS GANADORAS','1','1','007','007','5','5','1','1','HerramientasVenta/Comprar','2','2','0','0');
end;

use [BelcorpCostaRica_BPT];
go

begin
	declare @ConfiguracionPaisCostaRicaID int;
	
	set @ConfiguracionPaisCostaRicaID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,DesktopTitulo,MobileTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBpt,DesktopUsarImagenFondo,MobileUsarImagenFondo) values 
	(@ConfiguracionPaisCostaRicaID,'201801','2','2','PE_2018511276_bbymyqsrgu.png','herramientas-venta-mobile.jpg','LAS MÁS GANADORAS','LAS MÁS GANADORAS','1','1','007','007','5','5','1','1','HerramientasVenta/Comprar','2','2','0','0');
end;