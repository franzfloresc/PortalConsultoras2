USE BelcorpPeru
GO

-- LIMPINADO LOS DATOS DE RECOMENDACIONES DE CONFIGUACION PAIS --
DELETE FROM ConfiguracionPaisDatos WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisID FROM configuracionpais WHERE codigo = 'RECOMDS')
DELETE FROM ConfiguracionPais WHERE Codigo = 'RECOMDS'
GO