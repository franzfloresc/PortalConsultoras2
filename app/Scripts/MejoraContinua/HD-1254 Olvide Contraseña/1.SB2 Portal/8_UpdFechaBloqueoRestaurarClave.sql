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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpMexico
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpColombia
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpVenezuela
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpSalvador
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpPuertoRico
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpPanama
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpGuatemala
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpEcuador
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpDominicana
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpCostaRica
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpChile
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

USE BelcorpBolivia
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
		Update Usuario set FechaBloqueoCorreo = GETDATE() where CodigoUsuario = @CodigoConsultora

	IF (@TipoBloqueo = 'SMS')
		Update Usuario set FechaBloqueoCelular = GETDATE() where CodigoUsuario = @CodigoConsultora
END
GO

