USE BelcorpBolivia
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpCostaRica
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpChile
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpColombia
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpDominicana
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpEcuador
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpGuatemala
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpMexico
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpPanama
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpPeru
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpPuertoRico
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpSalvador
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
USE BelcorpVenezuela
GO
IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
	DROP PROC UpdMatrizComercialImagen
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO
