GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'

	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status
	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
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
			--@ProductoSugeridoID
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
		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end

END

GO
