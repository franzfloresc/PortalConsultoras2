USE BelcorpPeru
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpMexico
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpEcuador
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpSalvador
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpPuertoRico
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpPanama
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpGuatemala
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpDominicana
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpCostaRica
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpChile
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpBolivia
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

USE BelcorpColombia
GO
	DELETE [ConfiguracionPaisDatos] WHERE CODIGO='FlujoPagoLinea'
GO

UPDATE ConfiguracionPais 
SET ESTADO = 0
WHERE CODIGO='PAYONLINE'

GO

UPDATE TablaLogicaDatos
SET Valor = 0
WHERE Codigo = 'FLAG_ENABLE_APP'