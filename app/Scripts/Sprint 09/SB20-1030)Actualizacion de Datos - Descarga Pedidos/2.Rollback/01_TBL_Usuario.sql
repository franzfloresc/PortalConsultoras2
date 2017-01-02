GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Usuario' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.Usuario
	DROP COLUMN TelefonoTrabajo;
END
GO