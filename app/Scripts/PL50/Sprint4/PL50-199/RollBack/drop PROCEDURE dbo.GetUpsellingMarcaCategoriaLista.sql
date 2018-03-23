USE BelcorpPeru_pl50
GO

IF (OBJECT_ID('dbo.GetUpsellingMarcaCategoriaLista', 'P') IS not NULL)
	drop PROCEDURE dbo.GetUpsellingMarcaCategoriaLista;
GO
 