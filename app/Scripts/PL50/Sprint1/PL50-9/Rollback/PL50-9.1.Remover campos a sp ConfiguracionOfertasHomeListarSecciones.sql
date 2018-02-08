use BelcorpPeru
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO

use BelcorpBolivia
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpChile
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpColombia
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpCostaRica
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpDominicana
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpEcuador
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpGuatemala
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpMexico
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpPanama
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpPuertoRico
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpSalvador
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


use BelcorpVenezuela
GO


ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
/*
ConfiguracionOfertasHomeListarSecciones 201713
*/
BEGIN
	SET NOCOUNT ON;

	declare @TablaConfOfertaHome table (
		CampaniaID int,
		ConfiguracionPaisID int
	)

	insert into @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID 
	FROM ConfiguracionOfertasHome with(nolock)
	WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
	group by  ConfiguracionPaisID 

	SELECT
		O.ConfiguracionOfertasHomeID,
		O.ConfiguracionPaisID,
		O.CampaniaID,
		O.DesktopOrden,
		O.MobileOrden,
		O.DesktopImagenFondo,
		O.MobileImagenFondo,
		O.DesktopTitulo,
		O.MobileTitulo,
		O.DesktopSubTitulo,
		O.MobileSubTitulo,
		O.DesktopTipoPresentacion,
		O.MobileTipoPresentacion,
		O.DesktopTipoEstrategia,
		O.MobileTipoEstrategia,
		O.DesktopCantidadProductos,
		O.MobileCantidadProductos,
		O.DesktopActivo,
		O.MobileActivo,
		O.UrlSeccion,
		O.DesktopOrdenBpt,
		O.MobileOrdenBPT,
		C.Codigo 
	FROM ConfiguracionOfertasHome O with(nolock)
	inner join @TablaConfOfertaHome OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END

GO


