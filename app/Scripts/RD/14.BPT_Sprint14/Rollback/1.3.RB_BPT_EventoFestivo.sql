USE BelcorpPeru
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpMexico
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpColombia
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpVenezuela
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpSalvador
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpPuertoRico
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpPanama
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpGuatemala
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpEcuador
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpDominicana
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpCostaRica
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpChile
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

USE BelcorpBolivia
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
	PRINT ('Rollback Cambio tama�o de columna ''EventoFestivo.Nombre'' de 50 a 30 caracteres.')
	ALTER TABLE EventoFestivo
	ALTER COLUMN Nombre VARCHAR(30);
END

