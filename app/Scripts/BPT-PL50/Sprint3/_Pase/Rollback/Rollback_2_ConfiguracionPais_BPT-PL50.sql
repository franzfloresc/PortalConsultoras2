
USE BelcorpChile
GO

UPDATE ConfiguracionPais SET Activo = 1 WHERE Codigo = 'OFC'
UPDATE ConfiguracionPais SET Activo = 1 WHERE Codigo = 'OFCGM'
UPDATE ConfiguracionPais SET Activo = 0 WHERE Codigo = 'OFR'

