GO
ALTER PROCEDURE GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		CodigoUsuario,
		CodigoConsultora,
		PaisID,
		Nombre,
		ClaveSecreta,
		EMail,
		EMailActivo,
		Telefono,
		Celular,
		Sobrenombre,
		CompartirDatos,
		Activo,
		TipoUsuario,
		CambioClave
	from dbo.Usuario
	where EMail = @EMail and EMailActivo = 1;
END
GO
