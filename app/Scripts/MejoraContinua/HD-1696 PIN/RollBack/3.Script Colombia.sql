USE BelcorpPeru
GO
--ACTIVA PIN
delete from TablaLogicaDatos where TablaLogicaID = 137
delete from TablaLogica where TablaLogicaID = 137

-- NUEVA COLUMNA TieneAutenticacion
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='TieneAutenticacion')
BEGIN
	ALTER TABLE Usuario drop column TieneAutenticacion
END
GO

-- NUEVA TABLA - CODIGO GENERADO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END

-- NUEVA TABLA ConfiguracionSms
IF EXISTS (select 1 from sys.objects where type = 'U' and name = 'ConfiguracionSms')
BEGIN
	drop table ConfiguracionSms
END
GO

-- NUEVO PROCEDURE GetConfiguracionSms
IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetConfiguracionSms')
BEGIN
	DROP PROC GetConfiguracionSms
END
GO

-- NUEVO SCRIPT GetPinAutenticacion
IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetPinAutenticacion')
BEGIN
	DROP PROC GetPinAutenticacion
END
GO

-- NUEVO SP InsCodigoGenerado
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoGenerado')
BEGIN
	DROP PROC InsCodigoGenerado
END
GO

-- NUEVO SP GetCodigoGenerado
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetCodigoGenerado')
BEGIN
	DROP PROC [dbo].[GetCodigoGenerado]
END
GO

-- NUEVO SP GetHabilitaOpcion
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROC [dbo].[GetHabilitaOpcion]
END
GO

-- NUEVA TABLA LogEnvioSMS
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END

-- NUEVO SP InsLogEnvioSMS
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO