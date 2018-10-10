USE BelcorpBolivia
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

USE BelcorpChile
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


USE BelcorpColombia
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpMexico
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

USE BelcorpPanama
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

USE BelcorpPeru
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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


