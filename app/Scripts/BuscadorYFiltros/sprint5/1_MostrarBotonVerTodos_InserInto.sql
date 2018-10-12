GO
USE BelcorpPeru
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpMexico
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpColombia
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpSalvador
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpPuertoRico
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpPanama
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpGuatemala
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpEcuador
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpDominicana
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpCostaRica
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpChile
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
USE BelcorpBolivia
GO

DECLARE @id int = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'B&F')
IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'MostrarBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'MostrarBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe mostrar el botón VerTodos', 1, NULL)
END

IF NOT EXISTS (SELECT 1 FROM ConfiguracionPaisDatos WHERE codigo = 'AplicarLogicaCantidadBotonVerTodos')
BEGIN
   INSERT INTO ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@id, 'AplicarLogicaCantidadBotonVerTodos', 0, 1, NULL, NULL, 'Define si se debe aplicar la logica para MostrarBotonVerTodos, segun cantidad', 1, NULL)
END

GO
