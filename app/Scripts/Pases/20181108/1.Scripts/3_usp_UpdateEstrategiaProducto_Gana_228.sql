USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'usp_UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.usp_UpdateEstrategiaProducto
END
GO

CREATE PROCEDURE dbo.usp_UpdateEstrategiaProducto
 @EstrategiaId INT
,@CUV VARCHAR(20)
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END
GO