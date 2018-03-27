USE BelcorpPeru_pl50
GO

IF (OBJECT_ID('dbo.UpsellingMarcaCategoriaFlagsEditar', 'P') IS not NULL)
	drop PROCEDURE dbo.UpsellingMarcaCategoriaFlagsEditar  
GO
 