USE BelcorpPeru_PL50
GO

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END
GO