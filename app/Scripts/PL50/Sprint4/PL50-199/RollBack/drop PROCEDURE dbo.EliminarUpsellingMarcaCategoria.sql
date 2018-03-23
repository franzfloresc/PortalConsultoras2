USE BelcorpPeru_pl50
GO

IF (OBJECT_ID('dbo.EliminarUpsellingMarcaCategoria', 'P') IS not NULL)
	drop PROCEDURE dbo.EliminarUpsellingMarcaCategoria ;
GO
 