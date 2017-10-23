USE BelcorpPeru
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7, 0, 0
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT
	INSERT INTO ConfiguracionPais 
	(
		Codigo,	Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, DesktopTituloMenu, Orden, DesktopTituloBanner,
		MobileTituloBanner, UrlMenu, OrdenBpt
	)
	VALUES
	(
		'DES-NAV', 1, 'Descargables Navideños',	1, 1, 201716, 'Personaliza|Descarga e Imprime', 7, '#Nombre, Todas tus ofertas en un solo lugar.',
		'#Nombre, Todas tus ofertas en un solo lugar.', '#', 7
	)
	
	SET @ConfiguracionPaisID = SCOPE_IDENTITY()

	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID

	/*** CAMAPAÑA 201716***/
	INSERT INTO ConfiguracionOfertasHome 
	(
		ConfiguracionPaisID, CampaniaID, DesktopOrden, MobileOrden, DesktopTitulo, DesktopTipoPresentacion, MobileTipoPresentacion, DesktopCantidadProductos,
		MobileCantidadProductos, DesktopActivo, MobileActivo, DesktopOrdenBpt, MobileOrdenBpt
	) 
	VALUES
	(
		@ConfiguracionPaisID, 201716, 7, 0, 'Descarga E Imprime', 7, 0, 0, 0, 1, 0, 100, 0
	)
END
GO

