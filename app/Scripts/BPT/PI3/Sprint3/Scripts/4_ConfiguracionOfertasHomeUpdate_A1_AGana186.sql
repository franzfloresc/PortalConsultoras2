--EAAR

use BelcorpPeru_Bpt

go

GO

print db_name()

go



ALTER PROCEDURE [ConfiguracionOfertasHomeUpdate] 
@ConfiguracionOfertasHomeID int,
@ConfiguracionPaisID int,
@CampaniaID int,
@DesktopOrden int,
@MobileOrden int,
@DesktopImagenFondo varchar(250),
@MobileImagenFondo varchar(250),
@DesktopTitulo varchar(250),
@MobileTitulo varchar(250),
@DesktopSubTitulo varchar(250),
@MobileSubTitulo varchar(250),
@DesktopTipoPresentacion int,
@MobileTipoPresentacion int,
@DesktopTipoEstrategia varchar(250),
@MobileTipoEstrategia varchar(250),
@DesktopCantidadProductos int,
@MobileCantidadProductos int,
@DesktopActivo bit,
@MobileActivo bit,
@UrlSeccion varchar(250),
@DesktopOrdenBpt int,
@MobileOrdenBpt int,
@DesktopColorFondo varchar(10),
@MobileColorFondo varchar(10),
@DesktopUsarImagenFondo bit,
@MobileUsarImagenFondo bit,
@DesktopColorTexto varchar(10),
@MobileColorTexto varchar(10),

@BotonTexto1 varchar(100),
@BotonTexto2 varchar(100),
@BotonColor varchar(10),
@BotonColorTexto varchar(10)
AS 
BEGIN
	SET NOCOUNT ON

	DECLARE @InsertedId INT = 0

	IF(@ConfiguracionOfertasHomeID = 0)
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHome 
		(
			ConfiguracionPaisID,
			CampaniaID,
			DesktopOrden,
			MobileOrden,
			DesktopImagenFondo,
			MobileImagenFondo,
			DesktopTitulo,
			MobileTitulo,
			DesktopSubTitulo,
			MobileSubTitulo,
			DesktopTipoPresentacion,
			MobileTipoPresentacion,
			DesktopTipoEstrategia,
			MobileTipoEstrategia,
			DesktopCantidadProductos,
			MobileCantidadProductos,
			DesktopActivo,
			MobileActivo,
			UrlSeccion,
			DesktopOrdenBpt,
			MobileOrdenBpt,
			DesktopColorFondo,
			MobileColorFondo,
			DesktopUsarImagenFondo,
			MobileUsarImagenFondo, 
			DesktopColorTexto,
			MobileColorTexto,

			BotonTexto1,
			BotonTexto2,
			BotonColor,
			BotonColorTexto
		)
		VALUES 
		(
			@ConfiguracionPaisID,
			@CampaniaID,
			@DesktopOrden,
			@MobileOrden,
			@DesktopImagenFondo,
			@MobileImagenFondo,
			@DesktopTitulo,
			@MobileTitulo,
			@DesktopSubTitulo,
			@MobileSubTitulo,
			@DesktopTipoPresentacion,
			@MobileTipoPresentacion,
			@DesktopTipoEstrategia,
			@MobileTipoEstrategia,
			@DesktopCantidadProductos,
			@MobileCantidadProductos,
			@DesktopActivo,
			@MobileActivo,
			@UrlSeccion,
			@DesktopOrdenBpt,
			@MobileOrdenBpt,
			@DesktopColorFondo,
			@MobileColorFondo,
			@DesktopUsarImagenFondo,
			@MobileUsarImagenFondo, 
			@DesktopColorTexto,
			@MobileColorTexto,

			@BotonTexto1,
			@BotonTexto2,
			@BotonColor,
			@BotonColorTexto  
		)

		SET @insertedId = SCOPE_IDENTITY();
	END
	ELSE 
	BEGIN
		UPDATE ConfiguracionOfertasHome 
		SET
			ConfiguracionPaisID = @ConfiguracionPaisID,
			CampaniaID = @CampaniaID,
			DesktopOrden = @DesktopOrden,
			MobileOrden = @MobileOrden,
			DesktopImagenFondo = @DesktopImagenFondo,
			MobileImagenFondo = @MobileImagenFondo,
			DesktopTitulo = @DesktopTitulo,
			MobileTitulo = @MobileTitulo,
			DesktopSubTitulo = @DesktopSubTitulo,
			MobileSubTitulo = @MobileSubTitulo,
			DesktopTipoPresentacion = @DesktopTipoPresentacion,
			MobileTipoPresentacion = @MobileTipoPresentacion,
			DesktopTipoEstrategia = @DesktopTipoEstrategia,
			MobileTipoEstrategia = @MobileTipoEstrategia,
			DesktopCantidadProductos = @DesktopCantidadProductos,
			MobileCantidadProductos = @MobileCantidadProductos,
			DesktopActivo = @DesktopActivo,
			MobileActivo = @MobileActivo,
			UrlSeccion = @UrlSeccion,
			DesktopOrdenBpt = @DesktopOrdenBpt,
			MobileOrdenBpt = @MobileOrdenBpt,
			DesktopColorFondo = @DesktopColorFondo,
			MobileColorFondo = @MobileColorFondo,
			DesktopUsarImagenFondo = @DesktopUsarImagenFondo,
			MobileUsarImagenFondo = @MobileUsarImagenFondo, 
			DesktopColorTexto = @DesktopColorTexto,
			MobileColorTexto = @MobileColorTexto,

			BotonTexto1=@BotonTexto1,
			BotonTexto2=@BotonTexto2,
			BotonColor=@BotonColor,
			BotonColorTexto=@BotonColorTexto  

		WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

		SET @insertedId = @ConfiguracionOfertasHomeID;
	END

	SELECT @insertedId
END

