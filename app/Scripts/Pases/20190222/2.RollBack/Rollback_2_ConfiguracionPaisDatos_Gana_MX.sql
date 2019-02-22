USE BelcorpMexico
GO

UPDATE dbo.ConfiguracionPaisDatos
SET Valor1 = '',
	Estado = 0
WHERE Codigo = 'EstrategiaDisponible'