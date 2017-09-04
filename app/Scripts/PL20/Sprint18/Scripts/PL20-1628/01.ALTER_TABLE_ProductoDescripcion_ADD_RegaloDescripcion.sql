USE BelcorpPeru
GO

IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 

GO


USE BelcorpColombia
GO

IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 

GO


USE BelcorpMexico
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO

USE BelcorpMexico_Plan20
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpChile
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO

USE BelcorpChile_Plan20
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpBolivia
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpEcuador
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpCostaRica
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpDominicana
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpGuatemala
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpPanama
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpPuertoRico
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpSalvador
GO
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO


USE BelcorpVenezuela
GO
IF(NOT EXISTS(	SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	ADD RegaloDescripcion VARCHAR(500)
END 
GO
