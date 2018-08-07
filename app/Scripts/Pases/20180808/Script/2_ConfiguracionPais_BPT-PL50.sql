
USE BelcorpChile
GO

UPDATE ConfiguracionPais SET Estado = 0 WHERE Codigo = 'OFC'
UPDATE ConfiguracionPais SET Estado = 0 WHERE Codigo = 'OFCGM'
UPDATE ConfiguracionPais SET Estado = 1, Excluyente = 0 WHERE Codigo = 'OFR'
