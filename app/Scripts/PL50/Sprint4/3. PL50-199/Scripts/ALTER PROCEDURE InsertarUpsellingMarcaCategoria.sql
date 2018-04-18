USE Belcorpbolivia
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go

USE BelcorpChile
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpColombia
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpCostaRica
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpDominicana
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpEcuador
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpGuatemala
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpMexico
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpPanama
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpPeru
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpPuertoRico
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
USE BelcorpSalvador
GO

IF (OBJECT_ID('dbo.InsertarUpsellingMarcaCategoria', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarUpsellingMarcaCategoria AS SET NOCOUNT ON;')
GO

alter PROCEDURE dbo.InsertarUpsellingMarcaCategoria @UpSellingId INT
	,@MarcaID CHAR(2)
	,@CategoriaID CHAR(2)
AS
BEGIN
	INSERT INTO [dbo].[Upselling_Marca_Categoria] (
		[UpsellingID]
		,[MarcaID]
		,[CategoriaID]
		)
	VALUES (
		@UpSellingId
		,@MarcaID
		,@CategoriaID
		)

		
EXEC GetUpsellingMarcaCategoriaLista @UpSellingId
	,@MarcaID
	,@CategoriaID

END

go
