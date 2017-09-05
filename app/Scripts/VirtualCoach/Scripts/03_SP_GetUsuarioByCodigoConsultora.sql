GO
IF OBJECT_ID('GetUsuarioByCodigoConsultora', 'P') IS NOT NULL
	DROP PROC GetUsuarioByCodigoConsultora
GO
CREATE PROCEDURE dbo.GetUsuarioByCodigoConsultora
	@CodigoConsultora varchar(20)
AS
BEGIN
	select
		U.CodigoUsuario,
		U.CodigoConsultora,
		U.PaisID,
		U.Nombre as NombreCompleto,
		U.EMail,
		U.EMailActivo,
		U.Telefono,
		U.TelefonoTrabajo,
		U.Celular,
		U.Sobrenombre,
		C.PrimerNombre,
		U.CompartirDatos,
		U.TipoUsuario,
		U.CambioClave
	from dbo.Usuario U
	left join ods.Consultora C on U.CodigoConsultora = C.Codigo
	where U.CodigoConsultora = @CodigoConsultora;
END
GO