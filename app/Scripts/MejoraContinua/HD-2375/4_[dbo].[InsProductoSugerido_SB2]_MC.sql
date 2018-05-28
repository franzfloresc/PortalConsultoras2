GO
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpMexico
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpColombia
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpSalvador
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpPuertoRico
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpPanama
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpGuatemala
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpEcuador
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpDominicana
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpCostaRica
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpChile
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
USE BelcorpBolivia
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
	,@MostrarAgotado INT
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
			UPDATE ProductoSugeridoPadre SET UsuarioModificacion = @UsuarioRegistro, FechaModificacion = GETDATE(), MostrarAgotado = @MostrarAgotado
			WHERE CUV = @CUV AND CampaniaID = @CampaniaID
		END
		ELSE
		BEGIN
			INSERT INTO ProductoSugeridoPadre(CampaniaID, CUV, MostrarAgotado, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion)
			VALUES(@CampaniaID, @CUV, @MostrarAgotado, @UsuarioRegistro, GETDATE(), NULL, NULL)
		END
	END
END

GO
