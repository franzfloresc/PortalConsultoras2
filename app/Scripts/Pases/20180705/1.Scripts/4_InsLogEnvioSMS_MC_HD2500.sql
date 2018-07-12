USE BelcorpPeru
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpMexico
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpColombia
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpSalvador
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpPanama
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpEcuador
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpDominicana
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpChile
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

USE BelcorpBolivia
GO

IF EXISTS (select 1 from sys.objects where type = 'P' and name = 'InsLogEnvioSMS')
BEGIN
	DROP PROC [dbo].[InsLogEnvioSMS]
END
GO
CREATE PROC [dbo].[InsLogEnvioSMS]
(
@OrigenID int,
@CodigoUsuario varchar(20),
@CodigoConsultora varchar(20),
@OrigenDescripcion varchar(50),
@Usuario varchar(30),
@Contrasenia varchar(30),
@CampaniaID varchar(6),
@Celular varchar(18),
@MensajeEnviado varchar(200),
@CodigoRespuesta varchar(15),
@MensajeRespuesta varchar(180),
@EsMobile bit
)
AS
BEGIN 
	insert into [dbo].[LogEnvioSMS]
	(
		[OrigenID],
		[CodigoUsuario],
		[CodigoConsultora],
		[OrigenDescripcion],
		[Usuario],
		[Contrasenia],
		[CampaniaID],
		[Celular],
		[MensajeEnviado],
		[CodigoRespuesta],
		[MensajeRespuesta],
		[EsMobile],
		[FechaEnvio]		
	)
	values
	(
		@OrigenID,
		@CodigoUsuario,
		@CodigoConsultora,
		@OrigenDescripcion,
		@Usuario,
		@Contrasenia,
		@CampaniaID,
		@Celular,
		@MensajeEnviado,
		@CodigoRespuesta,
		@MensajeRespuesta,
		@EsMobile,
		GETDATE()
	)
END
GO

