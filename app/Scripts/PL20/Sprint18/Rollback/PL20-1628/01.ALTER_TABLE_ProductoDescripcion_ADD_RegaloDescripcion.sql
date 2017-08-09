USE BelcorpPeru
GO

IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 

GO


USE BelcorpColombia
GO

IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END  

GO


USE BelcorpMexico
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO

USE BelcorpMexico_Plan20
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpChile
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO

USE BelcorpChile_Plan20
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpBolivia
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpEcuador
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpCostaRica
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpDominicana
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpGuatemala
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpPanama
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpPuertoRico
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END  
GO


USE BelcorpSalvador
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO


USE BelcorpVenezuela
GO
IF(EXISTS(		SELECT SC.NAME
				FROM SYS.OBJECTS SO
				JOIN SYS.COLUMNS SC ON SO.[OBJECT_ID] = SC.[OBJECT_ID]
				WHERE SO.TYPE = 'U'
				AND SO.NAME = 'ProductoDescripcion'
				AND SC.NAME = 'RegaloDescripcion'))
BEGIN
	ALTER TABLE ProductoDescripcion
	DROP COLUMN RegaloDescripcion
END 
GO
