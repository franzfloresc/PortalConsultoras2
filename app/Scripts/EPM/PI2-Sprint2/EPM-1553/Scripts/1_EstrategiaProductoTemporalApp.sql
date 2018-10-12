
USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'CampaniaApp' AND OBJECT_ID = OBJECT_ID(N'EstrategiaProductoTemporalApp'))
BEGIN
	ALTER TABLE EstrategiaProductoTemporalApp
	ADD CampaniaApp INT;
END  
GO
