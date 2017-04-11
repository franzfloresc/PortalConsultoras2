USE [BelcorpColombia]
GO
/****** Object:  StoredProcedure [ShowRoom].[GetEventoConsultoraRecibido]    Script Date: 10/04/2017 09:48:10 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


USE BelcorpBolivia
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpChile
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpColombia
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpCostaRica
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpDominicana
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpEcuador
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpGuatemala
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpMexico
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpPanama
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpPeru
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpPuertoRico
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpSalvador
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

/*end*/

USE BelcorpVenezuela
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='GetEventoConsultoraRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[GetEventoConsultoraRecibido]
@CodigoConsultora varchar(25),
@CampaniaID int
as
select top 1 convert(bit,isnull(Recibido,0)) as Recibido from ShowRoom.EventoConsultora
where CodigoConsultora = @CodigoConsultora and
CampaniaID = @CampaniaID

GO

