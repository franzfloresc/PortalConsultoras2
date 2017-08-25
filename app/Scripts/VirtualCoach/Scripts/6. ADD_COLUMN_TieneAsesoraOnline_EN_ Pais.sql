USE BelcorpChile
GO

ALTER TABLE dbo.Pais ADD TieneAsesoraOnline INT NULL;
GO

UPDATE Pais
SET TieneAsesoraOnline = 1
WHERE CodigoISO LIKE 'CL'
GO