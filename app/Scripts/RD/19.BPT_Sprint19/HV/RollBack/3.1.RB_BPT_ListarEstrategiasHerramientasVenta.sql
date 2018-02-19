USE [BelcorpPeru_BPT]
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO