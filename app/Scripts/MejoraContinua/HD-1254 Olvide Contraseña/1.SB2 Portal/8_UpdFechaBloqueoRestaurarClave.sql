USE BelcorpPeru
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpMexico
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpColombia
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpVenezuela
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpSalvador
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpPuertoRico
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpPanama
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpGuatemala
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpEcuador
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpDominicana
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpCostaRica
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpChile
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

USE BelcorpBolivia
GO

USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'UpdFechaBloqueoRestaurarClave')
BEGIN
	DROP PROC UpdFechaBloqueoRestaurarClave
END
GO
CREATE PROC UpdFechaBloqueoRestaurarClave
(
@CodigoConsultora varchar(20),
@TipoBloqueo varchar(10)
)
AS
BEGIN
	IF (@TipoBloqueo = 'CORREO')
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora or DocumentoIdentidad = @CodigoConsultora
END
GO

