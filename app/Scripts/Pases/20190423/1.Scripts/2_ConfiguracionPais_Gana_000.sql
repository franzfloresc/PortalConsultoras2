USE BelcorpPeru
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpMexico
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpColombia
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpSalvador
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpPuertoRico
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpPanama
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpGuatemala
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpEcuador
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpDominicana
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpCostaRica
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpChile
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

USE BelcorpBolivia
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
	DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')

	 INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	 VALUES (@ConfiguracionPaisID, 'GuardaDataEnLocalStorage', 0, '011,101,005,007,008,010', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Localstorage. Ejm.(011,101,007,008,010)', 1, NULL)

	INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
	VALUES (@ConfiguracionPaisID, 'GuardaDataEnSession', 0, '001,005,101,007,008', NULL, NULL, 'C�digo de estrategia que trabajaran OFFLINE-Session. Ejm.(001,005,101,007,008,009)', 1, NULL)
END

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
   DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('EstrategiaDisponibleParaFicha')

   INSERT INTO dbo.ConfiguracionPaisDatos (ConfiguracionPaisID, Codigo, CampaniaID, Valor1, Valor2, Valor3, Descripcion, Estado, Componente)
   VALUES (@ConfiguracionPaisID, 'EstrategiaDisponibleParaFicha', 0, '', NULL, NULL, 'Estrategia disponible en microservicio personalizaci�n para ficha', 1, NULL)
END
GO

