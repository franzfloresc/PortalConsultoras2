GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'TelefonoTrabajo'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	DROP COLUMN TelefonoTrabajo;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'Latitud'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	DROP COLUMN Latitud;
END
GO
IF (EXISTS(
	SELECT 1 
	FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'LogCargaConsultora' AND COLUMN_NAME = 'Longitud'
))
BEGIN
	ALTER TABLE dbo.LogCargaConsultora
	DROP COLUMN Longitud;
END
GO