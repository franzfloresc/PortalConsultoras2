
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV2 VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV2 = @CUV2
END
GO

