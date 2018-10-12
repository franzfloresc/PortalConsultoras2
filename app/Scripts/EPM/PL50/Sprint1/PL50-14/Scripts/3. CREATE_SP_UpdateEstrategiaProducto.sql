

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
	DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO

CREATE PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV2 VARCHAR(20)
,@Precio MONEY
--,@PrecioValorizado money
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  --Campania = @Campania
		--,CUV = @CUV
		--,CUV2 = @CUV2
		Precio = @Precio
		--,PrecioValorizado = @PrecioValorizado
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV2 = @CUV2
END
GO
