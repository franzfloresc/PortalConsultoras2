GO
ALTER PROCEDURE GetUsuario
	@CodigoUsuario varchar(20)
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
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO