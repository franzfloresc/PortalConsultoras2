USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConfiguracionOfertasHomeListarSecciones]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ConfiguracionOfertasHomeListarSecciones
GO

CREATE PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId int
AS
BEGIN
	SET NOCOUNT ON;
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
	FROM ConfiguracionOfertasHome O
	inner join (
		SELECT MAX(CampaniaID) as CampaniaID, ConfiguracionPaisID 
		FROM ConfiguracionOfertasHome 
		WHERE CampaniaID <= @CampaniaId and isnull(CampaniaID, 0) > 0
		group by  ConfiguracionPaisID 
	) OC on 
		O.CampaniaID = OC.CampaniaID and O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	where 
		MobileActivo = 1 or DesktopActivo = 1
END
GO
/*end*/