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
	declare @FechaModificacion datetime = getdate();

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