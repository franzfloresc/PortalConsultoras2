USE BelcorpEcuador
GO

UPDATE dbo.ConfiguracionPais
SET Estado = 0
WHERE Codigo = 'MSPersonalizacion'

GO

USE BelcorpBolivia
GO

UPDATE dbo.ConfiguracionPais
SET Estado = 0
WHERE Codigo = 'MSPersonalizacion'

GO