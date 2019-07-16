USE BelcorpColombia_APP
GO

DELETE FROM [dbo].[BeneficioCaminoBrillante]   
DBCC CHECKIDENT (BeneficioCaminoBrillante, RESEED, 0)  
GO