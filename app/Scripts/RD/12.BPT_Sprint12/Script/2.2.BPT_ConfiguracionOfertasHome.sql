
GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201715,
	0, 0,
	0, 0,
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	1, 1,
	''
)

GO
