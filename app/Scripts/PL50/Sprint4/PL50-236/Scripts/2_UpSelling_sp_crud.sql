USE BelcorpPeru
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

USE BelcorpBolivia
GO

IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Select'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Select
GO

--UpSelling_Select null, null
CREATE PROCEDURE [dbo].UpSelling_Select (
	@UpSellingId INT = NULL
	,@CodigoCampana VARCHAR(6) = NULL
	)
AS
SET NOCOUNT ON;

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (
		@UpSellingId IS NULL
		OR UpSellingId = @UpSellingId
		)
	AND (
		@CodigoCampana IS NULL
		OR CodigoCampana = @CodigoCampana
		)
ORDER BY CodigoCampana DESC
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioCreacion VARCHAR(150)
	,@FechaCreacion DATETIME	
	)
AS
SET NOCOUNT OFF;

INSERT INTO [UpSelling] (
	[CodigoCampana]
	,[TextoMetaPrincipal]
	,[TextoInferior]
	,[TextoGanastePrincipal]
	,[TextoGanasteBoton]
	,[TextoGanastePremio]
	,[ImagenFondoPrincipalDesktop]
	,[ImagenFondoPrincipalMobile]
	,[ImagenFondoGanasteMobile]
	,[Activo]
	,[UsuarioCreacion]
	,[FechaCreacion]
	)
VALUES (
	@CodigoCampana
	,@TextoMetaPrincipal
	,@TextoInferior
	,@TextoGanastePrincipal
	,@TextoGanasteBoton
	,@TextoGanastePremio
	,@ImagenFondoPrincipalDesktop
	,@ImagenFondoPrincipalMobile
	,@ImagenFondoGanasteMobile
	,@Activo
	,@UsuarioCreacion
	,@FechaCreacion
	);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
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
	,@TextoMetaPrincipal VARCHAR(250)
	,@TextoInferior VARCHAR(250)
	,@TextoGanastePrincipal VARCHAR(250)
	,@TextoGanasteBoton VARCHAR(250)
	,@TextoGanastePremio VARCHAR(250)
	,@ImagenFondoPrincipalDesktop VARCHAR(250)
	,@ImagenFondoPrincipalMobile VARCHAR(250)
	,@ImagenFondoGanasteMobile VARCHAR(250)
	,@Activo BIT
	,@UsuarioModificacion VARCHAR(150)
	,@FechaModificacion DATETIME
	,@UpSellingId INT
	)
AS
SET NOCOUNT OFF;

UPDATE [UpSelling]
SET [CodigoCampana] = @CodigoCampana
	,[TextoMetaPrincipal] = @TextoMetaPrincipal
	,[TextoInferior] = @TextoInferior
	,[TextoGanastePrincipal] = @TextoGanastePrincipal
	,[TextoGanasteBoton] = @TextoGanasteBoton
	,[TextoGanastePremio] = @TextoGanastePremio
	,[ImagenFondoPrincipalDesktop] = @ImagenFondoPrincipalDesktop
	,[ImagenFondoPrincipalMobile] = @ImagenFondoPrincipalMobile
	,[ImagenFondoGanasteMobile] = @ImagenFondoGanasteMobile
	,[Activo] = @Activo
	,[UsuarioModificacion] = @UsuarioModificacion
	,[FechaModificacion] = @FechaModificacion
WHERE ([UpSellingId] = @UpSellingId);

SELECT UpSellingId
	,CodigoCampana
	,TextoMetaPrincipal
	,TextoInferior
	,TextoGanastePrincipal
	,TextoGanasteBoton
	,TextoGanastePremio
	,ImagenFondoPrincipalDesktop
	,ImagenFondoPrincipalMobile
	,ImagenFondoGanasteMobile
	,Activo
	,UsuarioCreacion
	,FechaCreacion
	,UsuarioModificacion
	,FechaModificacion
FROM UpSelling
WHERE (UpSellingId = @UpSellingId)
GO

/*DELETE*/
IF EXISTS (
		SELECT *
		FROM sysobjects
		WHERE name = 'UpSelling_Delete'
			AND user_name(uid) = 'dbo'
		)
	DROP PROCEDURE [dbo].UpSelling_Delete
GO

CREATE PROCEDURE [dbo].UpSelling_Delete (@UpSellingId INT)
AS
SET NOCOUNT OFF;

DELETE
FROM [UpSelling]
WHERE ([UpSellingId] = @UpSellingId)
GO

