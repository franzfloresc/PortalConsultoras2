GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuario]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetUsuario]
GO

CREATE PROCEDURE dbo.GetUsuario
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
