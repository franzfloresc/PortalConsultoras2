USE BelcorpBolivia
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN

---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END

END
GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN

---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END

END
GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END

END
GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
		
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN

---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END

END
GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN

---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END

END
GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO


BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
		
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END

END
GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN
	
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID('UpdMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC UpdMatrizComercialImagen
GO

BEGIN

---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END

END
GO



