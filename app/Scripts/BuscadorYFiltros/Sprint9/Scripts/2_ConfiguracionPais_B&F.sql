USE BelcorpPeru
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpMexico
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpColombia
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpSalvador
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpPuertoRico
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpPanama
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpGuatemala
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpEcuador
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpDominicana
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpCostaRica
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpChile
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

USE BelcorpBolivia
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'

-- AGREGANDO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
INSERT INTO ConfiguracionPais (Codigo, Excluyente, Descripcion, Estado, TienePerfil, DesdeCampania)
VALUES ('RECOMDS', 1, 'Recomendaciones de productos similares', 1, 0, 0)

DECLARE @idConfiguracionPais int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@idConfiguracionPais, 'ActivarRecomendaciones', 0, '0', NULL, NULL, 'Flag para activar las recomendaciones.', 1, NULL),
	(@idConfiguracionPais, 'MaximoResultados', 0, '6', NULL, NULL, 'Valor para filtrar la cantidad maxima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'MinimoResultados', 0, '1', NULL, NULL, 'Valor para filtrar la camtidad minima de recomendaciones a mostrar.', 1, NULL),
	(@idConfiguracionPais, 'CaracteresDescripcion', 0, '35', '35', NULL, 'Valor para reducir los carateres de descripcion (valor1-desktop, valor2-mobile ).', 1, NULL),
	(@idConfiguracionPais, 'CodigoCatalogo', 0, '9,10,13', NULL, NULL, 'Valores de los codigos de catalogo que se considera para mostrar recomendaciones', 1, NULL)

GO

