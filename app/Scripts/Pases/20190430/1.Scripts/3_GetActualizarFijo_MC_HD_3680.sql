USE BelcorpBolivia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpChile
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpColombia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpCostaRica
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpDominicana
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpEcuador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpGuatemala
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpMexico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpPanama
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpPeru
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 

USE BelcorpSalvador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetActualizarFijo]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetActualizarFijo] 

GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : ACTUALIZA LA EL CELULAR DEL USUARIO 
*/ 
CREATE PROCEDURE GetActualizarFijo 
	@CODIGOCONSULTORA VARCHAR(32), 
	@TIPOENVIO        VARCHAR(32), 
	@FIJOANTERIOR     VARCHAR(16), 
	@FIJOACTUAL       VARCHAR(16) 
AS 
BEGIN 
    IF ( (SELECT COUNT(1) 
        FROM   VALIDACIONDATOS 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO) > 0 ) 
    BEGIN 
        /*ACTUALIZACIÓN DE DATOS EN TABLA VALIDACIONDATOS*/ 
        UPDATE VALIDACIONDATOS 
        SET    ESTADO = 'S', 
                DATOANTIGUO = @FIJOANTERIOR, 
                DATONUEVO = @FIJOACTUAL, 
                CAMPANIAACTIVACIONEMAIL = 0, 
                USUARIOMODIFICACION = @CODIGOCONSULTORA, 
                FECHAMODIFICACION = GETDATE() 
        WHERE  CODIGOUSUARIO = @CODIGOCONSULTORA 
                AND TIPOENVIO = @TIPOENVIO 
    END 
    ELSE 
    BEGIN 
        /*INSERCIÓN DE DATOS EN L ATABLA VALIDACIONDATOS*/ 
        INSERT INTO VALIDACIONDATOS 
                    (TIPOENVIO, 
                        DATOANTIGUO, 
                        DATONUEVO, 
                        CODIGOUSUARIO, 
                        ESTADO, 
                        CAMPANIAACTIVACIONEMAIL, 
                        FECHACREACION, 
                        USUARIOCREACION, 
                        IPDISPOSITIVO, 
                        DISPOSITIVO) 
        SELECT @TIPOENVIO, 
                @FIJOANTERIOR, 
                @FIJOACTUAL, 
                @CODIGOCONSULTORA, 
                'S', 
                0, 
                GETDATE(), 
                @CODIGOCONSULTORA, 
                NULL, 
                NULL 
    END 
END 
GO 