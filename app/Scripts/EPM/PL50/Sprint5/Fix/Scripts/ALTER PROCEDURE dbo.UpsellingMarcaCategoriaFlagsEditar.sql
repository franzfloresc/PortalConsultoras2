USE BelcorpBolivia
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go

USE BelcorpChile
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go

USE BelcorpColombia
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpCostaRica
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpDominicana
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpEcuador
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpGuatemala
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpMexico
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpPanama
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpPeru
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpPuertoRico
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go
USE BelcorpSalvador
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
 	 
	IF (
			@CategoriaApoyada != NULL
			AND @CategoriaMonto != NULL
			)
	BEGIN
		UPDATE UpSelling
		SET CategoriaApoyada = @CategoriaApoyada
			,CategoriaMonto = @CategoriaMonto
		WHERE UpSellingId = @UpSellingId
	END

end
go

