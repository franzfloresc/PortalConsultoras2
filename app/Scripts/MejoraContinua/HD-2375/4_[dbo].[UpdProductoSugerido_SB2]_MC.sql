USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[UpdProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioModificacion varchar(50)
)
AS
BEGIN
	
	set @Return = '0|No se pudo actualizar el producto sugerido, vuelva a intentarlo luego.'
	
	DECLARE @Existe int = 0
	select @Existe = ProductoSugeridoID
	from ProductoSugerido
	where ProductoSugeridoID = @ProductoSugeridoID

	set @Existe = isnull(@Existe, 0)

	if	@Existe > 0
	begin
	
		DECLARE @return_status varchar(max);
		EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioModificacion;
		-- SELECT 'Return Status' = @return_status;
		set @Return = @return_status


		if	@return_status = ''
		begin

			UPDATE ProductoSugerido
			SET CampaniaID = @CampaniaID,
				CUV = @CUV,
				CUVSugerido = @CUVSugerido,
				Orden = @Orden,
				ImagenProducto = @ImagenProducto,
				Estado = @Estado,
				UsuarioModificacion = @UsuarioModificacion,
				FechaModificacion = GETDATE()
			WHERE ProductoSugeridoID = @ProductoSugeridoID

			set @Return = convert(varchar, @ProductoSugeridoID)  + '|Se actualizó con éxito el producto sugerido.'

			IF EXISTS(SELECT * FROM ProductoSugeridoPadre WHERE CUV = @CUV AND CampaniaID = @CampaniaID) /*HD-2375*/
			BEGIN
				UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()
				WHERE CUV = @CUV AND CampaniaID = @CampaniaID
			END
			ELSE
			BEGIN
				INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
				VALUES(@CampaniaID, @CUV, @UsuarioModificacion, GETDATE(), @UsuarioModificacion, GETDATE())
			END

		end
	end

END

