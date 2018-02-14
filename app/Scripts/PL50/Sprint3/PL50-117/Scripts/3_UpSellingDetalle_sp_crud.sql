IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSellingDetalle_Select' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSellingDetalle_Select
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Select
(
	@UpSellingId int
)
AS
	SET NOCOUNT ON;
SELECT UpSellingDetalleID, CUV, Nombre, Descripcion, Imagen, Stock, Orden, Activo, UpSellingId, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSellingDetalle WHERE UpSellingId = @UpSellingId
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSellingDetalle_Insert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSellingDetalle_Insert
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Insert
(
	@CUV varchar(50),
	@Nombre varchar(250),
	@Descripcion varchar(500),
	@Imagen varchar(400),
	@Stock int,
	@Orden int,
	@Activo bit,
	@UpSellingId int,
	@UsuarioCreacion varchar(150),
	@FechaCreacion datetime,
	@UsuarioModicacion varchar(150),
	@FechaModificacion datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO [UpSellingDetalle] ([CUV], [Nombre], [Descripcion], [Imagen], [Stock], [Orden], [Activo], [UpSellingId], [UsuarioCreacion], [FechaCreacion], [UsuarioModicacion], [FechaModificacion]) VALUES (@CUV, @Nombre, @Descripcion, @Imagen, @Stock, @Orden, @Activo, @UpSellingId, @UsuarioCreacion, @FechaCreacion, @UsuarioModicacion, @FechaModificacion);
	
SELECT UpSellingDetalleID, CUV, Nombre, Descripcion, Imagen, Stock, Orden, Activo, UpSellingId, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSellingDetalle WHERE (UpSellingDetalleID = SCOPE_IDENTITY())
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSellingDetalle_Update' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSellingDetalle_Update
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Update
(
	@CUV varchar(50),
	@Nombre varchar(250),
	@Descripcion varchar(500),
	@Imagen varchar(400),
	@Stock int,
	@Orden int,
	@Activo bit,
	@UpSellingId int,
	@UsuarioCreacion varchar(150),
	@FechaCreacion datetime,
	@UsuarioModicacion varchar(150),
	@FechaModificacion datetime,
	@Original_UpSellingDetalleID int,
	@Original_CUV varchar(50),
	@Original_Nombre varchar(250),
	@IsNull_Descripcion Int,
	@Original_Descripcion varchar(500),
	@IsNull_Imagen Int,
	@Original_Imagen varchar(400),
	@Original_Stock int,
	@Original_Orden int,
	@Original_Activo bit,
	@Original_UpSellingId int,
	@Original_UsuarioCreacion varchar(150),
	@Original_FechaCreacion datetime,
	@IsNull_UsuarioModicacion Int,
	@Original_UsuarioModicacion varchar(150),
	@IsNull_FechaModificacion Int,
	@Original_FechaModificacion datetime,
	@UpSellingDetalleID int
)
AS
	SET NOCOUNT OFF;
UPDATE [UpSellingDetalle] SET [CUV] = @CUV, [Nombre] = @Nombre, [Descripcion] = @Descripcion, [Imagen] = @Imagen, [Stock] = @Stock, [Orden] = @Orden, [Activo] = @Activo, [UpSellingId] = @UpSellingId, [UsuarioCreacion] = @UsuarioCreacion, [FechaCreacion] = @FechaCreacion, [UsuarioModicacion] = @UsuarioModicacion, [FechaModificacion] = @FechaModificacion WHERE (([UpSellingDetalleID] = @Original_UpSellingDetalleID) AND ([CUV] = @Original_CUV) AND ([Nombre] = @Original_Nombre) AND ((@IsNull_Descripcion = 1 AND [Descripcion] IS NULL) OR ([Descripcion] = @Original_Descripcion)) AND ((@IsNull_Imagen = 1 AND [Imagen] IS NULL) OR ([Imagen] = @Original_Imagen)) AND ([Stock] = @Original_Stock) AND ([Orden] = @Original_Orden) AND ([Activo] = @Original_Activo) AND ([UpSellingId] = @Original_UpSellingId) AND ([UsuarioCreacion] = @Original_UsuarioCreacion) AND ([FechaCreacion] = @Original_FechaCreacion) AND ((@IsNull_UsuarioModicacion = 1 AND [UsuarioModicacion] IS NULL) OR ([UsuarioModicacion] = @Original_UsuarioModicacion)) AND ((@IsNull_FechaModificacion = 1 AND [FechaModificacion] IS NULL) OR ([FechaModificacion] = @Original_FechaModificacion)));
	
SELECT UpSellingDetalleID, CUV, Nombre, Descripcion, Imagen, Stock, Orden, Activo, UpSellingId, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSellingDetalle WHERE (UpSellingDetalleID = @UpSellingDetalleID)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSellingDetalle_Delete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSellingDetalle_Delete
GO

CREATE PROCEDURE [dbo].UpSellingDetalle_Delete
(
	@Original_UpSellingDetalleID int,
	@Original_CUV varchar(50),
	@Original_Nombre varchar(250),
	@IsNull_Descripcion Int,
	@Original_Descripcion varchar(500),
	@IsNull_Imagen Int,
	@Original_Imagen varchar(400),
	@Original_Stock int,
	@Original_Orden int,
	@Original_Activo bit,
	@Original_UpSellingId int,
	@Original_UsuarioCreacion varchar(150),
	@Original_FechaCreacion datetime,
	@IsNull_UsuarioModicacion Int,
	@Original_UsuarioModicacion varchar(150),
	@IsNull_FechaModificacion Int,
	@Original_FechaModificacion datetime
)
AS
	SET NOCOUNT OFF;
DELETE FROM [UpSellingDetalle] WHERE (([UpSellingDetalleID] = @Original_UpSellingDetalleID) AND ([CUV] = @Original_CUV) AND ([Nombre] = @Original_Nombre) AND ((@IsNull_Descripcion = 1 AND [Descripcion] IS NULL) OR ([Descripcion] = @Original_Descripcion)) AND ((@IsNull_Imagen = 1 AND [Imagen] IS NULL) OR ([Imagen] = @Original_Imagen)) AND ([Stock] = @Original_Stock) AND ([Orden] = @Original_Orden) AND ([Activo] = @Original_Activo) AND ([UpSellingId] = @Original_UpSellingId) AND ([UsuarioCreacion] = @Original_UsuarioCreacion) AND ([FechaCreacion] = @Original_FechaCreacion) AND ((@IsNull_UsuarioModicacion = 1 AND [UsuarioModicacion] IS NULL) OR ([UsuarioModicacion] = @Original_UsuarioModicacion)) AND ((@IsNull_FechaModificacion = 1 AND [FechaModificacion] IS NULL) OR ([FechaModificacion] = @Original_FechaModificacion)))
GO

