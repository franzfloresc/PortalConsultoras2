IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

CREATE PROCEDURE [dbo].UpSelling_Select (
@UpSellingId INT = NULL
,@CodigoCampana VARCHAR(6) = NULL)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,MontoMeta
	,TextoMeta1
	,TextoMeta2
	,TextoGanaste1
	,TextoGanaste2
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModicacion
	,FechaModificacion
FROM UpSelling
WHERE (@UpSellingId IS NULL OR UpSellingId = @UpSellingId)
	AND (@CodigoCampana IS NULL OR CodigoCampana = @CodigoCampana)
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Insert'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Insert
GO

CREATE PROCEDURE [dbo].UpSelling_Insert (
	@CodigoCampana VARCHAR(6)
	,@MontoMeta DECIMAL(21, 4)
	,@TextoMeta1 VARCHAR(250)
	,@TextoMeta2 VARCHAR(250)
	,@TextoGanaste1 VARCHAR(250)
	,@TextoGanaste2 VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME
	,@UsuarioModicacion VARCHAR(150)
	,@FechaModificacion DATETIME
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[MontoMeta]
	,[TextoMeta1]
	,[TextoMeta2]
	,[TextoGanaste1]
	,[TextoGanaste2]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	,[UsuarioModicacion]
	,[FechaModificacion]
	)
VALUES (
	@CodigoCampana
	,@MontoMeta
	,@TextoMeta1
	,@TextoMeta2
	,@TextoGanaste1
	,@TextoGanaste2
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	,@UsuarioModicacion
	,@FechaModificacion
	);

SELECT UpSellingId
	,CodigoCampana
	,MontoMeta
	,TextoMeta1
	,TextoMeta2
	,TextoGanaste1
	,TextoGanaste2
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModicacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = SCOPE_IDENTITY())
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Update'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Update
GO

CREATE PROCEDURE [dbo].UpSelling_Update (
	@CodigoCampana VARCHAR(6)
	,@MontoMeta DECIMAL(21, 4)
	,@TextoMeta1 VARCHAR(250)
	,@TextoMeta2 VARCHAR(250)
	,@TextoGanaste1 VARCHAR(250)
	,@TextoGanaste2 VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME
	,@UsuarioModicacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[MontoMeta] = @MontoMeta
	,[TextoMeta1] = @TextoMeta1
	,[TextoMeta2] = @TextoMeta2
	,[TextoGanaste1] = @TextoGanaste1
	,[TextoGanaste2] = @TextoGanaste2
	,[Activo] = @Activo
	,[UsuarioCreacion] = @UsuarioCreacion
	,[FechaCreacion] = @FechaCreacion
	,[UsuarioModicacion] = @UsuarioModicacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,MontoMeta
	,TextoMeta1
	,TextoMeta2
	,TextoGanaste1
	,TextoGanaste2
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModicacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (
	@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO


