USE [BelcorpBolivia];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpChile];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpColombia];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpCostaRica];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpDominicana];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpEcuador];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpGuatemala];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpMexico];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpPanama];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpPeru];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpPuertoRico];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
USE [BelcorpSalvador];
GO
ALTER PROCEDURE dbo.GetUsuarioByEMail
	@EMail varchar(50)
AS
BEGIN
	select
		u.CodigoUsuario,
		u.CodigoConsultora,
		u.PaisID,
		u.Nombre,
		u.ClaveSecreta,
		u.EMail,
		u.EMailActivo,
		u.Telefono,
		u.TelefonoTrabajo,
		u.Celular,
		u.Sobrenombre,
		u.CompartirDatos,
		u.Activo,
		u.TipoUsuario,
		u.CambioClave,
		c.indicadorconsultoradigital,
		c.DigitoVerificador
	from dbo.Usuario u
	INNER JOIN ods.consultora c on c.codigo = u.codigoconsultora
	where u.EMail = @EMail and u.EMailActivo = 1;
END
GO
