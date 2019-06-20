USE BelcorpBolivia
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpChile
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpColombia
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpCostaRica
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpDominicana
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpEcuador
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpGuatemala
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpMexico
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpPanama
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpPeru
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpPuertoRico
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO

USE BelcorpSalvador
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'Dispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN Dispositivo 
END
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C	
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'	
	AND O.NAME = 'validacionDatos'
	AND C.NAME = 'IpDispositivo'
	)
BEGIN
	ALTER TABLE validacionDatos
	DROP COLUMN IpDispositivo 
END
GO