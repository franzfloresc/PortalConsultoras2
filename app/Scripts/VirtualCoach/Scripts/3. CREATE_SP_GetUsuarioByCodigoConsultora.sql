USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetUsuarioByCodigoConsultora]
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
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking
from dbo.Usuario U
where U.CodigoConsultora = @CodigoConsultora;
END
