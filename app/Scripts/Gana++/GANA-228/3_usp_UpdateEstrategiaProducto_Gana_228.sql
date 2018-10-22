USE BelcorpPeru_PL50
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

USE BelcorpChile_PL50
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
