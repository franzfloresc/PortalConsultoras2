USE BelcorpMexico
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DatosActualizadosUsuario' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.DatosActualizadosUsuario
	DROP COLUMN TelefonoTrabajo;
END
GO