USE BelcorpBolivia
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpChile
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpColombia
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpCostaRica
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpDominicana
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpEcuador
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpGuatemala
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpMexico
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpPanama
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpPeru
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpPuertoRico
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpSalvador
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO


USE BelcorpVenezuela
GO
IF EXISTS (select * from sys.objects where type = 'P' and name like '%UpdFlagEnvioCorreo%')
	DROP PROCEDURE [dbo].[UpdFlagEnvioCorreo]
GO
CREATE proc UpdFlagEnvioCorreo
(
@CodigoUsuario varchar(20)
)
as
BEGIN
Update [dbo].[UsuarioPostulante] set EnvioCorreo = 1 where CodigoUsuario = @CodigoUsuario
END
GO