USE BelcorpEcuador
GO

UPDATE dbo.ConfiguracionPaisDatos
SET Valor1 = '101,001,005,007,008,009,010,030,011',
	Estado = 1
WHERE Codigo = 'EstrategiaDisponible'

GO

USE BelcorpBolivia
GO

UPDATE dbo.ConfiguracionPaisDatos
SET Valor1 = '101,001,005,007,008,009,010,030,011',
	Estado = 1
WHERE Codigo = 'EstrategiaDisponible'

GO
