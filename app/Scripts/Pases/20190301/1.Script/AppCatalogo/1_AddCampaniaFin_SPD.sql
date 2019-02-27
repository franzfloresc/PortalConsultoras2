USE AppCatalogo
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = 'CampaniaFin'
          AND Object_ID = Object_ID('dbo.ProductoCampanaTemporalSB'))
BEGIN
	ALTER TABLE [dbo].[ProductoCampanaTemporalSB]
	ADD CampaniaFin int;
END
