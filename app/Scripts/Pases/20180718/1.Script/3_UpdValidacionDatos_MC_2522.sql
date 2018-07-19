﻿USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdValidacionDatos
END
GO
CREATE PROCEDURE dbo.UpdValidacionDatos
	@ValidacionID bigint,
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@Estado char(1),
	@CampaniaActivacionEmail int,
	@UsuarioModificacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionDatos
	set
		DatoAntiguo = @DatoAntiguo,
		DatoNuevo = @DatoNuevo,
		Estado = @Estado,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		FechaModificacion = @FechaModificacion,
		UsuarioModificacion = @UsuarioModificacion
	where ValidacionID = @ValidacionID;
END
GO