USE BelcorpChile
GO

--PRUEBA
IF EXISTS(SELECT * FROM ConfiguracionPaisDetalle WHERE CodigoConsultora LIKE '071859657')
BEGIN
	DELETE FROM ConfiguracionPaisDetalle WHERE CodigoConsultora LIKE '071859657'; 
END
GO