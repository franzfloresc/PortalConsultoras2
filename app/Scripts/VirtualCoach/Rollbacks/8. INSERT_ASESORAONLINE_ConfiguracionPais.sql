USE BelcorpChile
GO

IF EXISTS(SELECT * FROM ConfiguracionPais WHERE Codigo LIKE 'AO')
BEGIN
	DELETE FROM ConfiguracionPais WHERE Codigo LIKE 'AO'; 
END
GO