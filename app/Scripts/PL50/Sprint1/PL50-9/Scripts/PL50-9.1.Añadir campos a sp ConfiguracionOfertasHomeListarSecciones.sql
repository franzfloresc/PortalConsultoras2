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
		C.Codigo 
	FROM ConfiguracionOfertasHome O WITH(NOLOCK)
	INNER JOIN @TablaConfOfertaHome OC ON 
		O.CampaniaID = OC.CampaniaID AND O.ConfiguracionPaisID = OC.ConfiguracionPaisID
	LEFT JOIN ConfiguracionPais C ON 
		C.ConfiguracionPaisID = O.ConfiguracionPaisID
	WHERE 
		MobileActivo = 1 OR DesktopActivo = 1
END