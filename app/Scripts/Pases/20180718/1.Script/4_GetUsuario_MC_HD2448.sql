GO
USE BelcorpPeru
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpMexico
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpColombia
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpSalvador
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpPuertoRico
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpPanama
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpGuatemala
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpEcuador
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpDominicana
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpCostaRica
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpChile
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpBolivia
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
	U.TelefonoTrabajo,
	U.Celular,
	U.Sobrenombre,
	U.CompartirDatos,
	U.Activo,
	U.TipoUsuario,
	U.CambioClave,
	U.MostrarAyudaWebTraking,
	CAD.AceptoTerminos as AceptoContrato,
	C.indicadorconsultoradigital
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END


GO
