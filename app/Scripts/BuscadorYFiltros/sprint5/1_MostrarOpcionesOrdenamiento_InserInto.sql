USE BelcorpPeru
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpMexico
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpColombia
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpSalvador
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpPuertoRico
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpPanama
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpGuatemala
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpEcuador
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpDominicana
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpCostaRica
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpChile
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

USE BelcorpBolivia
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'MostrarOpcionesOrdenamiento')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'MostrarOpcionesOrdenamiento',0, 1, NULL, NULL, 'Flag para activar y/o deseactivar opciones de ordenamiento', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalProductosPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalProductosPaginaResultado',0, 20, NULL, NULL, 'Cantidad total de productos a mostrar en pagina resultados', 1, NULL)
END

IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'TotalCaracteresDescPaginaResultado')
BEGIN
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'TotalCaracteresDescPaginaResultado',0, 40, NULL, NULL, 'Cantidad total de caracteres de descripcion a mostrar en pagina resultados', 1, NULL)
END
GO

