USE BelcorpBolivia;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpChile;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpColombia;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpCostaRica;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpDominicana;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpEcuador;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpGuatemala;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpMexico;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpPanama;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpPeru;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpPuertoRico;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
USE BelcorpSalvador;
GO
declare @ConfiguracionPaisID int;
set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_nuevas_desktop.jpg','banner_nuevas_mobile.jpg'
		,'PACKS DE NUEVAS','PACKS DE NUEVAS'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);

set @ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');
delete from configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisID;

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
		,'3','3','3','3'
		,'banner_duo_desktop.jpg','banner_duo_mobile.jpg'
		,'DÚO PERFECTO','DÚO PERFECTO'
		,'4','4'
		,NULL,NULL
		,'0','0'
		,'1','1'
		,'ProgramaNuevas'
		,'0','0'
		);
GO
