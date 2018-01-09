USE BelcorpPeru
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpMexico
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpColombia
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpVenezuela
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpSalvador
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpPuertoRico
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpPanama
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpGuatemala
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpEcuador
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpDominicana
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpCostaRica
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpChile
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

USE BelcorpBolivia
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END
GO

