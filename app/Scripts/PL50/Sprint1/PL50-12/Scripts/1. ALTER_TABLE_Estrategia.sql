USE BelcorpPeru_PL50
GO
ALTER TABLE dbo.Estrategia ADD ImagenMiniaturaURL VARCHAR (200)
ALTER TABLE dbo.Estrategia ADD EsSubCampania BIT DEFAULT 0
