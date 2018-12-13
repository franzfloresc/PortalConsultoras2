USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'usp_UpdateEventoConsultoraPopup') 
  BEGIN 
      DROP PROCEDURE dbo.usp_updateeventoconsultorapopup 
  END 

go 

CREATE PROCEDURE Usp_updateeventoconsultorapopup @Tipo               CHAR (1), 
                                                 @EventoConsultoraId INT 
AS 
    IF @Tipo = 'I' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopup = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 

    IF @Tipo = 'V' 
      BEGIN 
          UPDATE showroom.eventoconsultora 
          SET    mostrarpopupventa = 0, 
                 fechamodificacion = Getdate() 
          WHERE  eventoconsultoraid = @EventoConsultoraId
      END 
GO





