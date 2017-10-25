
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
		'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		null, null,
		4, 4,
		null, null,
		0, 0,
		1, 1,
		'GuiaNegocio'
	)

end

GO
