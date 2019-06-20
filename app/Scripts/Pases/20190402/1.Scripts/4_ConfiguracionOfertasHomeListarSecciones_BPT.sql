GO
USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeListarSecciones]
	@CampaniaId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TablaConfOfertaHome TABLE (
		CampaniaID INT,
		ConfiguracionPaisID INT
	)

	INSERT INTO @TablaConfOfertaHome (CampaniaID,ConfiguracionPaisID)
	SELECT MAX(CampaniaID), ConfiguracionPaisID
	FROM ConfiguracionOfertasHome WITH(NOLOCK)
	WHERE CampaniaID <= @CampaniaId and ISNULL(CampaniaID, 0) > 0
	GROUP BY  ConfiguracionPaisID

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
		O.DesktopColorFondo,
		O.MobileColorFondo,
		O.DesktopUsarImagenFondo,
		O.MobileUsarImagenFondo,
		O.DesktopColorTexto,
		O.MobileColorTexto,
		O.BotonTexto1,
		O.BotonTexto2,
		O.BotonColor,
		O.BotonColorTexto,

		C.Codigo
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE
		MobileActivo = 1 OR DesktopActivo = 1
END
GO


GO
