USE BelcorpPeru_BPT
GO

IF EXISTS(
SELECT *
FROM SYS.OBJECTS O 
	JOIN SYS.COLUMNS C ON O.[OBJECT_ID] = C.[OBJECT_ID]
	AND O.TYPE = 'U'
	AND O.NAME = 'EventoFestivo'
	AND C.NAME = 'Nombre'
)
BEGIN
	PRINT ('Rollback Cambio tamaño de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END