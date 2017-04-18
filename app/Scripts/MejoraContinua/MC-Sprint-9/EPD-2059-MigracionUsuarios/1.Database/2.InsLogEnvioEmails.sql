USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogEnvioEmails]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsLogEnvioEmails]
GO

------------------------------------------------------------------------------------------
CREATE PROCEDURE InsLogEnvioEmails
 @CodigoConsultora varchar(25),
 @CodigoZona varchar(8),
 @FlgEnvio tinyint,
 @ConsecutivoNueva int,
 @EstadoEnvio tinyint,
 @EsPostulante BIT = 0,
 @CodigoUsuario VARCHAR(20)  = 0
AS
BEGIN
 SET NOCOUNT ON;
 
 INSERT INTO LogEnvioEmails VALUES (@CodigoConsultora,@CodigoZona,@FlgEnvio,@ConsecutivoNueva,@EstadoEnvio,dbo.fnObtenerFechaHoraPais())
 -- Colocar EnvioCorreo = 1 para los postulantes.
 IF @EsPostulante = 1
 UPDATE UsuarioPostulante SET EnvioCorreo = 1 WHERE CodigoUsuario = @CodigoUsuario 

END

GO

