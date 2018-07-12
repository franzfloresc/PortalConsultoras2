USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROCEDURE [dbo].[GetHabilitaOpcion]
END
GO
CREATE PROCEDURE [dbo].[GetHabilitaOpcion]
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @CorreoDesabilitado varchar(1) = '0'
	DECLARE @SmsDesabilitado varchar(1) = '0'

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and lower(TipoEnvio) = 'email' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	Update CodigoGenerado set OpcionDesabilitado = 0 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1 and DateDiff(Hour, FechaRegistro, Getdate()) >= 24

	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'email'and OpcionDesabilitado = 1
	print @CantidadHr_Correo

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaRegistro)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and lower(TipoEnvio) = 'sms' and OpcionDesabilitado = 1
	print @CantidadHr_Sms

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @CorreoDesabilitado = '1'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @SmsDesabilitado = '1'
	END

	SELECT 
		@CorreoDesabilitado as CorreoDesabilitado, 
		@SmsDesabilitado as SmsDesabilitado,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

