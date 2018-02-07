
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProductoAll]
@EstrategiaID INT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		--,UsuarioModificacion = @UsuarioModificacion
		--,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END
GO
