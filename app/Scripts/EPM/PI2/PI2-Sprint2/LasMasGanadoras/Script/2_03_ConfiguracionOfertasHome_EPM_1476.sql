use [BelcorpPeru_BPT];
go

begin
		
	declare @ConfiguracionPaisPeruID int;
	
	set @ConfiguracionPaisPeruID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(
		ConfiguracionPaisID
		,CampaniaID
		,DesktopOrden,MobileOrden,DesktopOrdenBpt,MobileOrdenBpt
		,DesktopImagenFondo,MobileImagenFondo
		,DesktopTitulo,MobileTitulo
		,DesktopTipoPresentacion,MobileTipoPresentacion
		,DesktopTipoEstrategia,MobileTipoEstrategia
		,DesktopCantidadProductos,MobileCantidadProductos
		,DesktopActivo,MobileActivo
		,UrlSeccion
		,DesktopUsarImagenFondo,MobileUsarImagenFondo
		) values  (
		@ConfiguracionPaisPeruID
		,'201801'
		,'2','2','2','2'
		,'banner_ganadoras_desktop.jpg','banner_ganadoras_mobile.jpg'
		,'LAS MÁS GANADORAS','LAS MÁS GANADORAS'
		,'9','9'
		,'007','007'
		,'5','5'
		,'1','1'
		,''
		,'0','0'
		);
end;
go

use [BelcorpChile_BPT];
go

begin
		
	declare @ConfiguracionPaisChileID int;
	
	set @ConfiguracionPaisChileID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisChileID;

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(
		ConfiguracionPaisID
		,CampaniaID
		,DesktopOrden,MobileOrden,DesktopOrdenBpt,MobileOrdenBpt
		,DesktopImagenFondo,MobileImagenFondo
		,DesktopTitulo,MobileTitulo
		,DesktopTipoPresentacion,MobileTipoPresentacion
		,DesktopTipoEstrategia,MobileTipoEstrategia
		,DesktopCantidadProductos,MobileCantidadProductos
		,DesktopActivo,MobileActivo
		,UrlSeccion
		,DesktopUsarImagenFondo,MobileUsarImagenFondo
		) values  (
		@ConfiguracionPaisChileID
		,'201801'
		,'2','2','2','2'
		,'banner_ganadoras_desktop.jpg','banner_ganadoras_mobile.jpg'
		,'LAS MÁS GANADORAS','LAS MÁS GANADORAS'
		,'9','9'
		,'007','007'
		,'5','5'
		,'1','1'
		,''
		,'0','0'
		);
end;
go

use [BelcorpCostaRica_BPT];
go

begin
		
	declare @ConfiguracionPaisCostaRicaID int;
	
	set @ConfiguracionPaisCostaRicaID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisCostaRicaID;

	-- inserta configuracionofertashome
	insert into dbo.configuracionofertashome(
		ConfiguracionPaisID
		,CampaniaID
		,DesktopOrden,MobileOrden,DesktopOrdenBpt,MobileOrdenBpt
		,DesktopImagenFondo,MobileImagenFondo
		,DesktopTitulo,MobileTitulo
		,DesktopTipoPresentacion,MobileTipoPresentacion
		,DesktopTipoEstrategia,MobileTipoEstrategia
		,DesktopCantidadProductos,MobileCantidadProductos
		,DesktopActivo,MobileActivo
		,UrlSeccion
		,DesktopUsarImagenFondo,MobileUsarImagenFondo
		) values  (
		@ConfiguracionPaisCostaRicaID
		,'201801'
		,'2','2','2','2'
		,'banner_ganadoras_desktop.jpg','banner_ganadoras_mobile.jpg'
		,'LAS MÁS GANADORAS','LAS MÁS GANADORAS'
		,'9','9'
		,'007','007'
		,'5','5'
		,'1','1'
		,''
		,'0','0'
		);
end;
go