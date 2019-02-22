USE BelcorpMexico
GO

UPDATE dbo.ConfiguracionPais
SET Estado = 0
WHERE Codigo = 'MSPersonalizacion'
