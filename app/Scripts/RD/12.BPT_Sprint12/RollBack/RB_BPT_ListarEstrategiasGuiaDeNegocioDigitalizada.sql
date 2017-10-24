IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
GO