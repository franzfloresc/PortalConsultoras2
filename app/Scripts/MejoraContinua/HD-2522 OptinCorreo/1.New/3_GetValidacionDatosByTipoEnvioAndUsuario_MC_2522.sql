GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetValidacionDatosByTipoEnvioAndUsuario' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetValidacionDatosByTipoEnvioAndUsuario
END
GO
CREATE PROCEDURE dbo.GetValidacionDatosByTipoEnvioAndUsuario
	@TipoEnvio varchar(15),
	@CodigoUsuario varchar(20)
AS
BEGIN
	select
		ValidacionID,
		TipoEnvio,
		DatoAntiguo,
		DatoNuevo,
		CodigoUsuario,
		Estado,
		CampaniaActivacionEmail,
		FechaCreacion,
		UsuarioCreacion,
		FechaModificacion,
		UsuarioModificacion
	from ValidacionDatos
	where TipoEnvio = @TipoEnvio and CodigoUsuario = @CodigoUsuario
END
GO