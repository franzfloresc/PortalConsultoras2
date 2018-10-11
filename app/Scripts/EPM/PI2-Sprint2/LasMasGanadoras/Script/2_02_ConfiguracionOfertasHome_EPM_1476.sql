use [BelcorpPeru_BPT];
go

begin
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
		
	declare @ConfiguracionPaisID int;
	
	set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
	
	delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID

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
		@ConfiguracionPaisID
		,'201801'
		,'2','2','2','2'
		,'','banner_ganadoras_mobile.jpg'
		,'LAS MÁS GANADORAS','LAS MÁS GANADORAS'
		,'1','9'
		,'007','007'
		,'5','5'
		,'1','1'
		,''
		,'0','0'
		);
end;
go