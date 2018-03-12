USE Belcorpmexico_pl50
GO

IF (OBJECT_ID('dbo.EliminarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.EliminarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.EliminarUpsellingMarcaCategoria 
 @UpSellingId int,  
 @MarcaID char(2),
 @CategoriaID char(2) 
AS
begin 

DELETE FROM [dbo].[Upselling_Marca_Categoria]
      WHERE [UpsellingID] =@UpSellingId and [MarcaID] =@MarcaID and [CategoriaID] =@CategoriaID 

end
go

