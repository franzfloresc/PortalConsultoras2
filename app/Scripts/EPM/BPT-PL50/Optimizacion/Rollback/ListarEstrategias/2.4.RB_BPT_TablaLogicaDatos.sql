USE [BelcorpPeru_BPT]
GO

IF EXISTS(SELECT TLD.Codigo FROM [dbo].[TablaLogicaDatos] TLD WHERE TLD.TablaLogicaDatosID = 10002)
BEGIN
	DELETE FROM [dbo].[TablaLogicaDatos] WHERE TablaLogicaDatosID = 10002
END