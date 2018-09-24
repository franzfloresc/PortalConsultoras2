GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM configuracionpaisDatos WHERE codigo = 'CantidadInicioSesionNovedadBuscador')
BEGIN
	DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
	INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@id, 'CantidadInicioSesionNovedadBuscador', 0, 2, NULL, NULL, 'Cantidad de veces que el usuario puede ingresar y ver el tooltip que presenta al buscador', 1, NULL)
END

GO
