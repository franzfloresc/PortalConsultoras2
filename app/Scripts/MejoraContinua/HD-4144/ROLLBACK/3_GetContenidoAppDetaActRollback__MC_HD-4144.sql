
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetContenidoAppDetaAct]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetContenidoAppDetaAct]
GO