

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais ADD TieneODD BIT
	GO

	UPDATE Pais SET TieneODD = 1 WHERE EstadoActivo = 1
	GO
END  

GO
/*end*/


USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais ADD TieneODD BIT
	GO

	UPDATE Pais SET TieneODD = 1 WHERE EstadoActivo = 1
	GO
END  

GO
/*end*/

USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
WHERE Name = N'TieneODD' AND OBJECT_ID = OBJECT_ID(N'Pais'))
BEGIN
	ALTER TABLE Pais ADD TieneODD BIT
	GO

	UPDATE Pais SET TieneODD = 1 WHERE EstadoActivo = 1
	GO
END  

GO

