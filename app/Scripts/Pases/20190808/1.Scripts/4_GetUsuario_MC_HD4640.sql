USE [BelcorpBolivia];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpChile];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpColombia];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpCostaRica];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpDominicana];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpEcuador];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpGuatemala];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpMexico];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpPanama];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpPeru];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpPuertoRico];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
USE [BelcorpSalvador];
GO
ALTER PROCEDURE dbo.GetUsuario
	@CodigoUsuario varchar(20)
AS
BEGIN

	--INI HD-3897
    declare @flgCheckSMS bit=0
	declare @flgCheckEMAIL bit=0

	if exists(select 1 from ValidacionDatos where TipoEnvio='Email' and CodigoUsuario=@CodigoUsuario and Estado='A')
		set @flgCheckEMAIL=1


	if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 1)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='A')
			set @flgCheckSMS=1

	end
	else if exists(select * from OpcionesVerificacion WHERE OrigenID = 3 AND Activo = 1 AND OpcionSms = 0)
	begin
		if exists(select 1 from ValidacionDatos where TipoEnvio='SMS' and CodigoUsuario=@CodigoUsuario and Estado='S')
			set @flgCheckSMS=1
	end

	--FIN HD-3897

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
	C.indicadorconsultoradigital,
	c.DigitoVerificador
	,@flgCheckSMS as  FlgCheckSMS --HD-3897
	,@flgCheckEMAIL as  FlgCheckEMAIL --HD-3897
from dbo.Usuario U
LEFT JOIN ods.Consultora C on U.CodigoConsultora= C.Codigo
LEFT JOIN dbo.ConsultoraAceptaData CAD on CAD.ConsultoraID = C.ConsultoraID
where U.CodigoUsuario = @CodigoUsuario;
END
GO
