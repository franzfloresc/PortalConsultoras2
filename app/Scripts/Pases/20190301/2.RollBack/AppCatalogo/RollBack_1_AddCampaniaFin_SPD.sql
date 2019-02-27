USE AppCatalogo
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = 'CampaniaFin'
          AND Object_ID = Object_ID('dbo.ProductoCampanaTemporalSB'))
BEGIN
   ALTER TABLE [dbo].[ProductoCampanaTemporalSB]
   DROP COLUMN CampaniaFin
END
