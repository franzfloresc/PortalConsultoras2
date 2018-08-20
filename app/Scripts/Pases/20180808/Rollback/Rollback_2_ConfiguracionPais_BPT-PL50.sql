
USE BelcorpChile
GO

UPDATE ConfiguracionPais SET Estado = 1 WHERE Codigo = 'OFC'
UPDATE ConfiguracionPais SET Estado = 1 WHERE Codigo = 'OFCGM'
UPDATE ConfiguracionPais SET Estado = 0, Excluyente = 1 WHERE Codigo = 'OFR'

