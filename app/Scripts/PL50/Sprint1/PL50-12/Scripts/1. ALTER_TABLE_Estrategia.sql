USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'ImagenMiniaturaURL' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD ImagenMiniaturaURL VARCHAR(200);
END  

IF NOT EXISTS(SELECT 1 FROM sys.columns
		WHERE Name = N'EsSubCampania' AND OBJECT_ID = OBJECT_ID(N'Estrategia'))
BEGIN
	ALTER TABLE Estrategia
	ADD EsSubCampania BIT DEFAULT 0;
END  

GO

