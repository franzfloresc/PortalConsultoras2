USE BelcorpPeru_PL50
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
	ADD EsSubCampania BIT DEFAULT 1;
END  

GO
