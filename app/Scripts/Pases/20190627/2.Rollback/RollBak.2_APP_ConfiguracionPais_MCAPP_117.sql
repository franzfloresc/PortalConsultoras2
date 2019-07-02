USE BelcorpPeru
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpMexico
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpColombia
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpSalvador
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpPuertoRico
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpPanama
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpGuatemala
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpEcuador
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpDominicana
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpCostaRica
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpChile
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

USE BelcorpBolivia
GO

DELETE ConfiguracionPaisDatos WHERE ConfiguracionPaisID IN (SELECT ConfiguracionPaisID FROM COnfiguracionPais WHERE CODIGO='BLOQUEO_PENDIENTE')
DELETE ConfiguracionPais WHERE Codigo='BLOQUEO_PENDIENTE'

GO

