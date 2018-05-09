USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpMexico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpColombia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpPanama
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpChile
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

USE BelcorpBolivia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetCodigoSMS')
BEGIN
	DROP PROC GetCodigoSMS
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
go
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoSMS')
BEGIN
	DROP TABLE [dbo].[CodigoSMS]
END
GO

