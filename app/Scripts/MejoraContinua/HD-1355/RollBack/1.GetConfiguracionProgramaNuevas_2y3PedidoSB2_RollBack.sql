USE BelcorpMexico
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetConfiguracionProgramaNuevas_2y3PedidoSB2')
BEGIN
	DROP PROCEDURE [dbo].[GetConfiguracionProgramaNuevas_2y3PedidoSB2]
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetConfiguracionProgramaNuevas_2y3PedidoSB2')
BEGIN
	DROP PROCEDURE [dbo].[GetConfiguracionProgramaNuevas_2y3PedidoSB2]
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'GetConfiguracionProgramaNuevas_2y3PedidoSB2')
BEGIN
	DROP PROCEDURE [dbo].[GetConfiguracionProgramaNuevas_2y3PedidoSB2]
END
GO

