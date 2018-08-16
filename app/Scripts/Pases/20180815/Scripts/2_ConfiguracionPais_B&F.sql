GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
BEGIN
	INSERT INTO configuracionpais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania, MobileTituloMenu,
		DesktopTituloMenu, Logo, Orden, DesktopTituloBanner, MobileTituloBanner, DesktopSubTituloBanner,
		MobileSubTituloBanner, DesktopFondoBanner, MobileFondoBanner, DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, OrdenBpt, MobileOrden, MobileOrdenBPT)
	VALUES ('B&F', 1, 'Buscador y Filtros', 1, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)

	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarBuscador', 0, 0, NULL, NULL, 'Mostrar u ocultar la opci�n de busqueda', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscador', 0, 3, NULL, NULL, 'Cantidad de caracteres para empezar la busqueda de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CaracteresBuscadorMostrar', 0, 25, NULL, NULL, 'Cantidad de caracteres que determina lo que se mostrara en la lista de productos', 1, NULL)

	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalResultadosBuscador', 0, 20, NULL, NULL, 'Cantidad de productos que se mostrara en la lista', 1, NULL)
END

GO
