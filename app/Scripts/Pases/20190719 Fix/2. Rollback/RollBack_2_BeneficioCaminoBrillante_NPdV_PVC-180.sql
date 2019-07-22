USE BelcorpColombia
GO

DELETE FROM [dbo].[BeneficioCaminoBrillante]   
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)  
GO