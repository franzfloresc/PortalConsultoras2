USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO
	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

USE BelcorpSalvador
GO
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'Encuesta' and schema_id = 1)
BEGIN

DROP TABLE dbo.Encuesta;

END
GO

