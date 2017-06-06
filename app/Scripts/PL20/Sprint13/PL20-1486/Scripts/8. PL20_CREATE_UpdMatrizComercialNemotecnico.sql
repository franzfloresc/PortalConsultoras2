USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpChile
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpColombia
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpMexico
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpPanama
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpPeru
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
USE BelcorpVenezuela
GO
IF OBJECT_ID('dbo.UpdMatrizComercialNemotecnico', 'P') IS NOT NULL
	DROP PROC dbo.UpdMatrizComercialNemotecnico
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;

GO
