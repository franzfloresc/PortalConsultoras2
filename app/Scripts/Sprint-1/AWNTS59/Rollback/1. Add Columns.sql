

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais DROP COLUMN TieneODD
END  

GO
/*end*/


USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais DROP COLUMN TieneODD
END  

GO
/*end*/


USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais DROP COLUMN TieneODD
END  

GO
