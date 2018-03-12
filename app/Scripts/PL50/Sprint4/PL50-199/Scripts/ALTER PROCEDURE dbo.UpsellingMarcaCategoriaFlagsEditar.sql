USE Belcorpmexico_pl50
GO

IF (OBJECT_ID('dbo.UpsellingMarcaCategoriaFlagsEditar', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpsellingMarcaCategoriaFlagsEditar AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.UpsellingMarcaCategoriaFlagsEditar 
 @UpSellingId int,  
 @CategoriaApoyada bit,
 @CategoriaMonto bit 
AS
begin
 	 
	 update UpSelling 
	 set CategoriaApoyada =@CategoriaApoyada, CategoriaMonto =@CategoriaMonto 
	 where  UpSellingId = @UpSellingId

end
go
