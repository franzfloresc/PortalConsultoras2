USE BelcorpColombia
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpMexico
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpPeru
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO