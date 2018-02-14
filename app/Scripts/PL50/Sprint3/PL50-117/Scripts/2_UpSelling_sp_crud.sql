IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSelling_Select' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSelling_Select
GO

CREATE PROCEDURE [dbo].UpSelling_Select
(
	@CodigoCampana int = NULL
)
AS
	SET NOCOUNT ON;
SELECT UpSellingId, CodigoCampana, MontoMeta, TextoMeta1, TextoMeta2, TextoGanaste1, TextoGanaste2, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSelling
WHERE (@CodigoCampana IS NULL OR (CodigoCampana = @CodigoCampana))
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSelling_Insert' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSelling_Insert
GO

CREATE PROCEDURE [dbo].UpSelling_Insert
(
	@CodigoCampana int,
	@MontoMeta decimal(21, 4),
	@TextoMeta1 varchar(250),
	@TextoMeta2 varchar(250),
	@TextoGanaste1 varchar(250),
	@TextoGanaste2 varchar(250),
	@UsuarioCreacion varchar(150),
	@FechaCreacion datetime,
	@UsuarioModicacion varchar(150),
	@FechaModificacion datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO [UpSelling] ([CodigoCampana], [MontoMeta], [TextoMeta1], [TextoMeta2], [TextoGanaste1], [TextoGanaste2], [UsuarioCreacion], [FechaCreacion], [UsuarioModicacion], [FechaModificacion]) VALUES (@CodigoCampana, @MontoMeta, @TextoMeta1, @TextoMeta2, @TextoGanaste1, @TextoGanaste2, @UsuarioCreacion, @FechaCreacion, @UsuarioModicacion, @FechaModificacion);
	
SELECT UpSellingId, CodigoCampana, MontoMeta, TextoMeta1, TextoMeta2, TextoGanaste1, TextoGanaste2, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSelling WHERE (UpSellingId = SCOPE_IDENTITY())
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSelling_Update' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSelling_Update
GO

CREATE PROCEDURE [dbo].UpSelling_Update
(
	@CodigoCampana int,
	@MontoMeta decimal(21, 4),
	@TextoMeta1 varchar(250),
	@TextoMeta2 varchar(250),
	@TextoGanaste1 varchar(250),
	@TextoGanaste2 varchar(250),
	@UsuarioCreacion varchar(150),
	@FechaCreacion datetime,
	@UsuarioModicacion varchar(150),
	@FechaModificacion datetime,
	@Original_UpSellingId int,
	@Original_CodigoCampana int,
	@Original_MontoMeta decimal(21, 4),
	@Original_TextoMeta1 varchar(250),
	@IsNull_TextoMeta2 Int,
	@Original_TextoMeta2 varchar(250),
	@IsNull_TextoGanaste1 Int,
	@Original_TextoGanaste1 varchar(250),
	@IsNull_TextoGanaste2 Int,
	@Original_TextoGanaste2 varchar(250),
	@Original_UsuarioCreacion varchar(150),
	@Original_FechaCreacion datetime,
	@IsNull_UsuarioModicacion Int,
	@Original_UsuarioModicacion varchar(150),
	@IsNull_FechaModificacion Int,
	@Original_FechaModificacion datetime,
	@UpSellingId int
)
AS
	SET NOCOUNT OFF;
UPDATE [UpSelling] SET [CodigoCampana] = @CodigoCampana, [MontoMeta] = @MontoMeta, [TextoMeta1] = @TextoMeta1, [TextoMeta2] = @TextoMeta2, [TextoGanaste1] = @TextoGanaste1, [TextoGanaste2] = @TextoGanaste2, [UsuarioCreacion] = @UsuarioCreacion, [FechaCreacion] = @FechaCreacion, [UsuarioModicacion] = @UsuarioModicacion, [FechaModificacion] = @FechaModificacion WHERE (([UpSellingId] = @Original_UpSellingId) AND ([CodigoCampana] = @Original_CodigoCampana) AND ([MontoMeta] = @Original_MontoMeta) AND ([TextoMeta1] = @Original_TextoMeta1) AND ((@IsNull_TextoMeta2 = 1 AND [TextoMeta2] IS NULL) OR ([TextoMeta2] = @Original_TextoMeta2)) AND ((@IsNull_TextoGanaste1 = 1 AND [TextoGanaste1] IS NULL) OR ([TextoGanaste1] = @Original_TextoGanaste1)) AND ((@IsNull_TextoGanaste2 = 1 AND [TextoGanaste2] IS NULL) OR ([TextoGanaste2] = @Original_TextoGanaste2)) AND ([UsuarioCreacion] = @Original_UsuarioCreacion) AND ([FechaCreacion] = @Original_FechaCreacion) AND ((@IsNull_UsuarioModicacion = 1 AND [UsuarioModicacion] IS NULL) OR ([UsuarioModicacion] = @Original_UsuarioModicacion)) AND ((@IsNull_FechaModificacion = 1 AND [FechaModificacion] IS NULL) OR ([FechaModificacion] = @Original_FechaModificacion)));
	
SELECT UpSellingId, CodigoCampana, MontoMeta, TextoMeta1, TextoMeta2, TextoGanaste1, TextoGanaste2, UsuarioCreacion, FechaCreacion, UsuarioModicacion, FechaModificacion FROM UpSelling WHERE (UpSellingId = @UpSellingId)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'UpSelling_Delete' AND user_name(uid) = 'dbo')
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete
(
	@Original_UpSellingId int,
	@Original_CodigoCampana int,
	@Original_MontoMeta decimal(21, 4),
	@Original_TextoMeta1 varchar(250),
	@IsNull_TextoMeta2 Int,
	@Original_TextoMeta2 varchar(250),
	@IsNull_TextoGanaste1 Int,
	@Original_TextoGanaste1 varchar(250),
	@IsNull_TextoGanaste2 Int,
	@Original_TextoGanaste2 varchar(250),
	@Original_UsuarioCreacion varchar(150),
	@Original_FechaCreacion datetime,
	@IsNull_UsuarioModicacion Int,
	@Original_UsuarioModicacion varchar(150),
	@IsNull_FechaModificacion Int,
	@Original_FechaModificacion datetime
)
AS
	SET NOCOUNT OFF;
DELETE FROM [UpSelling] WHERE (([UpSellingId] = @Original_UpSellingId) AND ([CodigoCampana] = @Original_CodigoCampana) AND ([MontoMeta] = @Original_MontoMeta) AND ([TextoMeta1] = @Original_TextoMeta1) AND ((@IsNull_TextoMeta2 = 1 AND [TextoMeta2] IS NULL) OR ([TextoMeta2] = @Original_TextoMeta2)) AND ((@IsNull_TextoGanaste1 = 1 AND [TextoGanaste1] IS NULL) OR ([TextoGanaste1] = @Original_TextoGanaste1)) AND ((@IsNull_TextoGanaste2 = 1 AND [TextoGanaste2] IS NULL) OR ([TextoGanaste2] = @Original_TextoGanaste2)) AND ([UsuarioCreacion] = @Original_UsuarioCreacion) AND ([FechaCreacion] = @Original_FechaCreacion) AND ((@IsNull_UsuarioModicacion = 1 AND [UsuarioModicacion] IS NULL) OR ([UsuarioModicacion] = @Original_UsuarioModicacion)) AND ((@IsNull_FechaModificacion = 1 AND [FechaModificacion] IS NULL) OR ([FechaModificacion] = @Original_FechaModificacion)))
GO

