USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador')
	DELETE FROM configuracionpaisDatos WHERE codigo = 'FlagFiltrosBuscador'

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
VALUES (@id, 'FlagFiltrosBuscador',0, 0, NULL, NULL, 'Flag para activar filtros en la página de resultados.', 1, NULL)
GO

