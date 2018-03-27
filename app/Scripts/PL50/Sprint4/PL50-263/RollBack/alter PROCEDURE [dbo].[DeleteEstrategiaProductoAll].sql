USE BelcorpBolivia
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpChile
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpColombia
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpCostaRica
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpDominicana
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpEcuador
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpGuatemala
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpMexico
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpPanama
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpPeru
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

USE BelcorpSalvador
GO

IF (OBJECT_ID('dbo.DeleteEstrategiaProductoAll', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.DeleteEstrategiaProductoAll AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[DeleteEstrategiaProductoAll] @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END

go

