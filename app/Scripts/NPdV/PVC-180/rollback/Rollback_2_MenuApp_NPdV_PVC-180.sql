USE BelcorpColombia
GO
	UPDATE  [dbo].[MenuApp] 
	SET [Visible] = 0
	WHERE [Codigo] = 'MEN_LAT_CAMINOBRILLANTE';
GO