﻿USE BelcorpBolivia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpChile
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpColombia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpCostaRica
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpDominicana
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpEcuador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpGuatemala
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpMexico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpPanama
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpPeru
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 

USE BelcorpSalvador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[GetTipoEnvioActivos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[GetTipoEnvioActivos]
GO
/* 
CREADO POR  : PAQUIRRI SEPERAK 
FECHA :    28/03/2019 
DESCRIPCIÓN : RETORNA LOS DATOS NECESARIOS PARA CARGAR EN LA APLICACIÒN 
*/ 
CREATE PROCEDURE GetTipoEnvioActivos
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN 
    SELECT TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO 
    FROM   VALIDACIONDATOS 
    WHERE  CODIGOUSUARIO = @CODIGOUSUARIO 
END 
GO 