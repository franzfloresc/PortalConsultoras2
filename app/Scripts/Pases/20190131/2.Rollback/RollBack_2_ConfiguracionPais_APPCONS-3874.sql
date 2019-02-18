USE BelcorpPeru
GO
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = ConfiguracionPaisID
FROM dbo.ConfiguracionPais
WHERE Codigo = 'DATAMI'

DELETE FROM dbo.ConfiguracionPaisDetalle
WHERE ConfiguracionPaisID = @ConfiguracionPaisID

DELETE FROM dbo.ConfiguracionPais
WHERE Codigo = 'DATAMI'
GO