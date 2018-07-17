GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsValidacionDatos' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.InsValidacionDatos
END
GO
CREATE PROCEDURE dbo.InsValidacionDatos
	@TipoEnvio varchar(15),
	@DatoAntiguo varchar(50),
	@DatoNuevo varchar(50),
	@CodigoUsuario varchar(20),
	@Estado char(1),
	@UsuarioCreacion varchar(20)
AS
BEGIN
	set nocount on;
	declare @FechaCreacion datetime = dbo.fnObtenerFechaHoraPais();

	insert into ValidacionDatos(
		TipoEnvio,
		DatoAntiguo,
		DatoNuevo,
		CodigoUsuario,
		Estado,
		CampaniaActivacionEmail,
		FechaCreacion,
		UsuarioCreacion		
	)
	values(
		@TipoEnvio,
		@DatoAntiguo,
		@DatoNuevo,
		@CodigoUsuario,
		@Estado,
		0,
		@FechaCreacion,
		@UsuarioCreacion	
	)
END
GO