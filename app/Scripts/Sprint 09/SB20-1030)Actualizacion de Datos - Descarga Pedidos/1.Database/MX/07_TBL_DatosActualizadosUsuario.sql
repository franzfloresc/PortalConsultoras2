USE BelcorpMexico
GO
IF (NOT EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DatosActualizadosUsuario' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.DatosActualizadosUsuario
	ADD TelefonoTrabajo VARCHAR(20);
END
GO