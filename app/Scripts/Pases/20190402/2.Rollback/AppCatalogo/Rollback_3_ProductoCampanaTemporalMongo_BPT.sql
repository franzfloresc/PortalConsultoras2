GO

USE AppCatalogo

GO

IF EXISTS (	SELECT 1
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'ProductoCampanaTemporalMongo'
			AND SO.[TYPE] = 'U')

BEGIN
	DROP TABLE [ProductoCampanaTemporalMongo]
END

GO
