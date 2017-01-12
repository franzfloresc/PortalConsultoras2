USE BelcorpBolivia
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpChile
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpCostaRica
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpDominicana
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpEcuador
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpGuatemala
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpPanama
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpPuertoRico
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpSalvador
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

USE BelcorpVenezuela
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO