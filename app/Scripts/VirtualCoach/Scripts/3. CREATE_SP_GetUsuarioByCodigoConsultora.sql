USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetUsuarioByCodigoConsultora' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetUsuarioByCodigoConsultora
END
GO
CREATE PROCEDURE dbo.GetUsuarioByCodigoConsultora
	@CodigoConsultora varchar(20)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.CodigoConsultora,
		U.PaisID,
		U.Nombre,
		U.ClaveSecreta,
		U.EMail,
		U.EMailActivo,
		U.Telefono,
		U.TelefonoTrabajo,
		U.Celular,
		U.Sobrenombre,
		C.PrimerNombre,
		U.CompartirDatos,
		U.Activo,
		U.TipoUsuario,
		U.CambioClave,
		U.MostrarAyudaWebTraking
	from dbo.Usuario U
	left join ods.Consultora C on U.CodigoConsultora = C.Codigo
	where U.CodigoConsultora = @CodigoConsultora;
END
GO
