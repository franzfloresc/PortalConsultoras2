USE [BelcorpPeru_GANAMAS]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetPromocionesByCondicion]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetPromocionesByCondicion]
GO