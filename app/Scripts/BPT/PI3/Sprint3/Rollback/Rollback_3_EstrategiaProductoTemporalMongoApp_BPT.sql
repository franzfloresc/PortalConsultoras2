
GO

IF EXISTS (	SELECT 1
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'EstrategiaProductoTemporalMongoApp'
			AND SO.[TYPE] = 'U')

BEGIN
	DROP TABLE [EstrategiaProductoTemporalMongoApp]
END

GO