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

	CREATE TABLE ProductoCampanaTemporalMongo
	(
	  ID int identity Primary key,
	  IsoPais varchar(5) null,
	  CampaniaIncio	int null,
	  Campania	int null,
	  CodigoSap varchar(100) null,
	  CampaniaFin int NULL
	)
