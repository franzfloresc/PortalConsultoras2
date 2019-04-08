
GO

print db_name()

go

ALTER PROCEDURE [dbo].[ConfiguracionOfertasHomeGet]
	@ConfiguracionOfertasHomeID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ConfiguracionOfertasHomeID,ConfiguracionPaisID,CampaniaID,DesktopOrden,MobileOrden,DesktopImagenFondo,MobileImagenFondo,
		DesktopTitulo,MobileTitulo,DesktopSubTitulo,MobileSubTitulo,DesktopTipoPresentacion,MobileTipoPresentacion,
		DesktopTipoEstrategia,MobileTipoEstrategia,DesktopCantidadProductos,MobileCantidadProductos,DesktopActivo,
		MobileActivo,UrlSeccion,DesktopOrdenBpt,MobileOrdenBPT,
		DesktopColorFondo, MobileColorFondo, DesktopUsarImagenFondo, MobileUsarImagenFondo, DesktopColorTexto, MobileColorTexto,
		BotonTexto1,
		BotonTexto2,
		BotonColor,
		BotonColorTexto
	FROM ConfiguracionOfertasHome AS P with(nolock)
	WHERE 
		P.ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID
END

GO
