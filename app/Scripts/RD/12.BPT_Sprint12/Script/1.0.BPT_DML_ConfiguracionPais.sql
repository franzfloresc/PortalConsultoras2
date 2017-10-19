
GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 1,
		1, 201715,
		0, 0, 0, 0,
		'Guía de Negocio Digitalizada', 'Guía de Negocio',
		'Guía de Negocio Digitalizada Desktop', 'Guía de Negocio Digitalizada',
		'Nueva Guía de Negocio Digitalizada Desktop', 'Nueva Guía de Negocio Digitalizada',
		'sr-banner-navidad-desktop.jpg', 'sr-banner-navidad-mobile.jpg',
		'sr-logo-navidad-desktop.png', 'sr-logo-navidad-mobile.png',
		'GuiaNegocio', null)
end

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

if @idConfiPaisDetalle > 0
begin
	delete from ConfiguracionPaisDetalle
	where ConfiguracionPaisID = @idConfiPaisDetalle

	insert into ConfiguracionPaisDetalle (
		ConfiguracionPaisID,
		CodigoRegion, CodigoZona,
		CodigoSeccion, CodigoConsultora,
		Estado, BloqueoRevistaImpresa
	)
	values (
		@idConfiPaisDetalle,
		'60', NULL,
		NULL, NULL,
		1, NULL
	)

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
		'PE_20171054749_bdvqxekshm.png', 'PE_20171054859_acaxdlgkur.png',
		'Guía de Negocio Desktop', 'Guía de Negocio',
		null, null,
		4, 4,
		null, null,
		0, 0,
		1, 1,
		'GuiaNegocio'
	)

end

GO
