USE BelcorpEcuador
GO

UPDATE dbo.ConfiguracionPaisDatos
SET Valor1 = '',
	Estado = 0
WHERE Codigo = 'EstrategiaDisponible'

GO

USE BelcorpBolivia
GO

UPDATE dbo.ConfiguracionPaisDatos
SET Valor1 = '',
	Estado = 0
WHERE Codigo = 'EstrategiaDisponible'

GO