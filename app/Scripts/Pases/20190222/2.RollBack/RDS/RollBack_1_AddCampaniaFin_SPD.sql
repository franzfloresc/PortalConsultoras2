USE AppCatalogo
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = 'CampaniaFin'
          AND Object_ID = Object_ID('AppCatalogo.ProductoCampanaTemporalSB'))
BEGIN
   ALTER TABLE [dbo].[ProductoCampanaTemporalSB]
   DROP COLUMN CampaniaFin
END
