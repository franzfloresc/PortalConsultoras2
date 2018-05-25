USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2](
	@Return VARCHAR(max) OUTPUT
	,@ProductoSugeridoID INT
	,@CampaniaID VARCHAR(6)
	,@CUV VARCHAR(20)
	,@CUVSugerido VARCHAR(20)
	,@Orden INT
	,@ImagenProducto VARCHAR(150)
	,@Estado INT
	,@UsuarioRegistro VARCHAR(50)
)
AS
BEGIN
	SET @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'
	
	DECLARE @return_status VARCHAR(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	
	SET @Return = @return_status

	IF @return_status = ''
	BEGIN
		INSERT INTO ProductoSugerido
		(
			CampaniaID
			,CUV
			,CUVSugerido
			,Orden
			,ImagenProducto
			,Estado
			,UsuarioRegistro
			,FechaRegistro
			,UsuarioModificacion
			,FechaModificacion
		)
		VALUES
		(
			@CampaniaID
			,@CUV
			,@CUVSugerido
			,@Orden
			,@ImagenProducto
			,@Estado
			,@UsuarioRegistro
			,getdate()
			,null
			,null
		)

		SET @Return = convert(VARCHAR, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'

		IF EXISTS(SELECT * FROM ProductoSugeridoPadre WHERE CUV = @CUV AND CampaniaID = @CampaniaID) /*HD-2375*/
		BEGIN
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE()
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
		
END

