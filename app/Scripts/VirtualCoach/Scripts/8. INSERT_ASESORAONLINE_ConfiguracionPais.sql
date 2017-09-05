USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'AO')
BEGIN
	INSERT INTO ConfiguracionPais(Codigo, Excluyente, Descripcion, Estado)
	VALUES ('AO', 0, 'Asesora Online', 1);
END
GO