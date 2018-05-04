USE BelcorpMexico
GO

--ACTIVA PIN
delete from TablaLogicaDatos where TablaLogicaID = 139
delete from TablaLogica where TablaLogicaID = 139
GO
insert into TablaLogica 
	values (139, 'PIN de autenticidad')
GO
insert into TablaLogicaDatos
	values (13901, 139, 'Activo','0',''),
		   (13902, 139, 'IdEstadoActividad','1',''),
		   (13903, 139, 'IdEstadoActividad','2',''),
		   (13904, 139, 'IdEstadoActividad','6',''),
		   (13905, 139, 'IdEstadoActividad','7',''),
		   (13906, 139, 'IdEstadoActividad','8','')
GO

-- NUEVA COLUMNA TieneAutenticacion
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='TieneAutenticacion')
BEGIN
	ALTER TABLE Usuario add TieneAutenticacion bit
END
GO

Update Usuario set TieneAutenticacion = 1
GO

-- NUEVA TABLA - CODIGO GENERADO
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' AND name = 'CodigoGenerado')
BEGIN
	DROP TABLE [dbo].[CodigoGenerado]
END

CREATE TABLE [dbo].[CodigoGenerado](
	[CodigoSmsId] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NULL,
	[OrigenDescripcion] [varchar](30) NULL,
	[TipoEnvio] [tinyint] NULL,
	[CodigoUsuario] [varchar](20) NULL,
	[CodigoGenerado] [varchar](6) NULL,
	[EsMobile] [bit] NULL,
	[OpcionHabilitada] [bit] NULL,	
	[FechaGeneracion] [datetime] NULL
	PRIMARY KEY ([CodigoSmsId])
)
GO

-- NUEVA TABLA ConfiguracionSms
if exists (select 1 from sys.objects where type = 'U' and name = 'ConfiguracionSms')
begin
	drop table ConfiguracionSms
end
go
CREATE TABLE ConfiguracionSms
(
	[ConfiguracionID] [int] IDENTITY(1,1) NOT NULL,
	[OrigenID] [int] NOT NULL,
	[OrigenDescripcion] [varchar](200) NULL,
	[IdEstadoActividad] [int] NULL,
	[CampaniaInicio] [int] NULL,
	[CampaniaFin] [int] NULL,
	[Mensaje] [varchar](500) NULL,
	[TieneCodigo] [bit] NULL,
	[ModoTest] [bit] NULL,
	[estado] [bit] NULL,
	CONSTRAINT PK_ConfiguracionSms_ConfiguracionID PRIMARY KEY(ConfiguracionID)
)

-- INSERTANDO DATA CONGIGURACION SMS
insert [dbo].[ConfiguracionSms]
values (1, 'RestaurarClave', 0, 0, 0, 'Su PIN de verificación para ingresar a Somos Belcorp es: {0}', 1, 1, 1),
	   (2, 'Autenticacion', 1, 0, 0, 'Su PIN de verificación para ingresar a Somos Belcorp es: {0}', 1, 1, 1)
   
GO

-- NUEVO PROCEDURE GetConfiguracionSms
if exists (select 1 from sys.objects where type = 'P' and name = 'GetConfiguracionSms')
begin
	drop proc GetConfiguracionSms
end
go
CREATE PROCEDURE GetConfiguracionSms
(
	@OrigenID int
)
AS
BEGIN
	SELECT top 1
		OrigenID,
		OrigenDescripcion,
		IdEstadoActividad,
		CampaniaInicio,
		CampaniaFin,
		Mensaje,
		cast(ModoTest as varchar(1)) as ModoTest,
		TieneCodigo
	FROM [dbo].[ConfiguracionSms]
	WHERE OrigenID = @OrigenID
	and Estado = 1
END
GO

-- NUEVO SCRIPT GetPinAutenticacion
if exists (select 1 from sys.objects where type = 'P' and name = 'GetPinAutenticacion')
begin
	drop proc GetPinAutenticacion
end
go
CREATE PROC GetPinAutenticacion
(
@CodgioUsuario VARCHAR(20)
)
AS
BEGIN
	DECLARE @TablaLogicaID INT = 139
	DECLARE @TEMP_LOGICADATOS table
	(
		Codigo varchar(20),
		Descripcion varchar(20)
	)

	DECLARE @TEMP_DATOS table
	(
		CodigoUsuario varchar(20),
		Email varchar(80),
		Celular varchar(15),
		PrimerNombre varchar(20),
		IdEstadoActividad int
	)

	DECLARE @Descripcion VARCHAR(20) = ''

	INSERT INTO @TEMP_LOGICADATOS
	SELECT 
		Codigo,
		Descripcion
	FROM 
	TablaLogicaDatos WITH(NOLOCK)
	WHERE TablaLogicaID = @TablaLogicaID

	SELECT @Descripcion = Descripcion FROM @TEMP_LOGICADATOS where lower(Codigo) = 'activo'

	IF (@Descripcion = '1')
	BEGIN
		INSERT INTO @TEMP_DATOS
		SELECT 
			U.CodigoUsuario,
			U.EMail,
			U.Celular,
			LEFT(C.PrimerNombre,1) + LOWER(SUBSTRING(C.PrimerNombre, 2, LEN(C.PrimerNombre))) AS PrimerNombre,
			C.IdEstadoActividad
		FROM 
		Usuario U WITH(NOLOCK)
		INNER JOIN ods.Consultora C WITH(NOLOCK) ON U.CodigoConsultora = C.Codigo
		WHERE U.CodigoUsuario = @CodgioUsuario
		AND U.TieneAutenticacion = 1
	END

	SELECT 
		CodigoUsuario,
		Email,
		Celular,
		PrimerNombre,
		IdEstadoActividad
	FROM @TEMP_DATOS WHERE IdEstadoActividad IN (SELECT cast(Descripcion as int) FROM @TEMP_LOGICADATOS WHERE lower(Codigo) = 'idestadoactividad')
END
GO

-- NUEVO SP InsCodigoGenerado
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoGenerado')
BEGIN
	DROP PROC InsCodigoGenerado
END
GO

CREATE PROC InsCodigoGenerado
(
@OrigenID int,
@TipoEnvio tinyint,
@CodigoUsuario varchar(20),
@CodigoGenerado varchar(6),
@EsMobile bit,
@OpcionHabilitada bit
)
AS
BEGIN	
	DECLARE @OrigenDescripcion varchar(50) = ''

	IF(@OrigenID = 1)
	BEGIN
		Set @OrigenDescripcion = 'Restaurar Contraseña'
	END

	IF(@OrigenID = 2)
	BEGIN
		Set @OrigenDescripcion = 'Pin Autenticacion'
	END
	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID and TipoEnvio = @TipoEnvio)
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
			   (OrigenID
			   ,OrigenDescripcion
			   ,TipoEnvio
			   ,CodigoUsuario
			   ,CodigoGenerado
			   ,EsMobile
			   ,OpcionHabilitada
			   ,FechaGeneracion)
		 VALUES
			   (@OrigenID
			   ,@OrigenDescripcion
			   ,@TipoEnvio
			   ,@CodigoUsuario
			   ,@CodigoGenerado
			   ,@EsMobile
			   ,1
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,EsMobile = @EsMobile
			  ,OpcionHabilitada = @OpcionHabilitada
			  ,FechaGeneracion = GETDATE()
		WHERE OrigenID = @OrigenID 
		and CodigoUsuario = @CodigoUsuario and TipoEnvio = @TipoEnvio
	END
END
GO

-- NUEVO SP GetCodigoGenerado
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetCodigoGenerado')
BEGIN
	DROP PROC [dbo].[GetCodigoGenerado]
END
GO
CREATE PROC [dbo].[GetCodigoGenerado] 
(
@CodigoUsuario varchar(20),
@OrigenID int,
@TipoEnvio int,
@CodigoIngresado varchar(8)
)
AS
BEGIN 

	DECLARE @Iguales varchar(1) = '0'

	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and TipoEnvio = @TipoEnvio
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set TieneAutenticacion = 0 where CodigoUsuario = @CodigoUsuario
		set @Iguales = '1'
	End

	select @Iguales as SonIguales
END
GO

-- NUEVO SP GetHabilitaOpcion
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'GetHabilitaOpcion')
BEGIN
	DROP PROC [dbo].[GetHabilitaOpcion]
END
GO

CREATE PROCEDURE GetHabilitaOpcion
(
@CodigoUsuario varchar(20),
@OrigenID int
)
AS
BEGIN

	DECLARE @CantidadHr_Correo INT
	DECLARE @CantidadHr_Sms INT
	DECLARE @FlagOpcion_Correo varchar(1) = '1'
	DECLARE @FlagOpcion_Sms varchar(1) = '1'

	Update CodigoGenerado set OpcionHabilitada = 1 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID 
	and TipoEnvio = 1 and OpcionHabilitada = 0 and DateDiff(Hour, FechaGeneracion, Getdate()) >= 24

	Update CodigoGenerado set OpcionHabilitada = 1 
	where CodigoUsuario = @CodigoUsuario and OrigenID = @OrigenID
	and TipoEnvio = 2 and OpcionHabilitada = 0 and DateDiff(Hour, FechaGeneracion, Getdate()) >= 24


	select @CantidadHr_Correo = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaGeneracion)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and TipoEnvio = 1 and OpcionHabilitada = 0
	print 'print correo: ' + cast(@CantidadHr_Correo as varchar(2))

	select @CantidadHr_Sms = DateDiff(Hour, GetDate(), (DateAdd(Day, 1, FechaGeneracion)))
	from [dbo].[CodigoGenerado] 
	where CodigoUsuario = @CodigoUsuario 
	and OrigenID = @OrigenID
	and TipoEnvio = 2 and OpcionHabilitada = 0
	print 'horas sms: ' + cast(@CantidadHr_Sms as varchar(2))

	IF (@CantidadHr_Correo > 0)
	BEGIN
		set @FlagOpcion_Correo = '0'
	END

	IF (@CantidadHr_Sms > 0)
	BEGIN
		set @FlagOpcion_Sms = '0'
	END

	SELECT 
		@FlagOpcion_Correo as OpcionCorreoActivo, 
		@FlagOpcion_Sms as OpcionSmsActivo,
		Isnull(@CantidadHr_Correo, 0) as HorasRestanteCorreo,
		Isnull(@CantidadHr_Sms, 0) as HorasRestanteSms
END
GO

-- NUEVA TABLA LogEnvioSMS
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'U' and name = 'LogEnvioSMS')
BEGIN
	DROP TABLE [dbo].[LogEnvioSMS]
END
CREATE TABLE [dbo].[LogEnvioSMS](
	[CodigoLog] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [varchar](30) NULL,
	[CodigoUsuario] [varchar](20) NULL,
	[MensajeEnviado] [varchar](180) NULL,
	[MensajeRespuesta] [varchar](180) NULL,
	[FechaEnvio] [datetime] NULL,
	PRIMARY KEY ([CodigoLog])
)
GO

-- NUEVO SP InsLogEnvioSMS
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@Origen varchar(30),
@CodigoUsuario varchar(20),
@MensajeEnviado varchar(180),
@MensajeRespuesta varchar(180)
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[Origen],
		[CodigoUsuario],
		[MensajeEnviado],
		[MensajeRespuesta],
		[FechaEnvio]
	)
	values
	(
		@Origen,
		@CodigoUsuario,
		@MensajeEnviado,
		@MensajeRespuesta,
		GETDATE()
	)
END