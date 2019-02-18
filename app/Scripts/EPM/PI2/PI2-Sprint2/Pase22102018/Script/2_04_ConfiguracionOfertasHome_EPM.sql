GO
USE BelcorpPeru
GO

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


GO
USE BelcorpMexico
GO

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


GO
USE BelcorpColombia
GO

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


GO
USE BelcorpSalvador
GO

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


GO
USE BelcorpPuertoRico
GO

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


GO
USE BelcorpPanama
GO

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


GO
USE BelcorpGuatemala
GO

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


GO
USE BelcorpEcuador
GO

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


GO
USE BelcorpDominicana
GO

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


GO
USE BelcorpCostaRica
GO

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


GO
USE BelcorpChile
GO

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


GO
USE BelcorpBolivia
GO

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


GO
