USE BelcorpBolivia
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpChile
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpColombia
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpCostaRica
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpDominicana
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpEcuador
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpGuatemala
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpMexico
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpPanama
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpPeru
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpPuertoRico
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/

USE BelcorpSalvador
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO

/*end*/


USE BelcorpVenezuela
GO
if EXISTS(SELECT name, SCHEMA_NAME(schema_id) AS schema_name, type
FROM sys.objects WHERE name ='UpdateEventoConsultoraEmailRecibido' AND type = 'P' AND SCHEMA_NAME(schema_id) = 'ShowRoom')
BEGIN
	DROP PROCEDURE [ShowRoom].[GetPersonalizacionNivel]
END
GO

CREATE procedure [ShowRoom].[UpdateEventoConsultoraEmailRecibido]
@CampaniaID int,
@CodigoConsultora varchar(25)
as
update ShowRoom.EventoConsultora set
Recibido = 1,
Envio = 1
where CodigoConsultora = @CodigoConsultora
and CampaniaID = @CampaniaID
GO
