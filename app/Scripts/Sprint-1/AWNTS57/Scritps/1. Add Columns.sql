
USE BelcorpBolivia
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

USE BelcorpChile
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


USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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


