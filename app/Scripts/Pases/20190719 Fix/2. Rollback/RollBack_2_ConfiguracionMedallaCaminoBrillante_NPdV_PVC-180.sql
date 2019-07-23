USE BelcorpColombia
GO
DELETE FROM [dbo].[ConfiguracionMedallaCaminoBrillante]  
DBCC CHECKIDENT (ConfiguracionMedallaCaminoBrillante, RESEED, 0) 
GO