USE [BelcorpPeru_GANAMAS]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetCondicionesByPromocion]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetCondicionesByPromocion]
GO