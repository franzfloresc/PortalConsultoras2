USE BelcorpBolivia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpChile
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpColombia
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpCostaRica
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpDominicana
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpEcuador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpGuatemala
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpMexico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpPanama
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpPeru
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO

USE BelcorpSalvador
GO
IF EXISTS (SELECT * 
           FROM   SYS.OBJECTS 
           WHERE  OBJECT_ID = OBJECT_ID(N'[DBO].[ListarValidacionDatos]') 
                  AND TYPE IN ( N'P', N'PC' )) 
  DROP PROCEDURE [DBO].[ListarValidacionDatos]
GO
/* 
-- NOMBRE        : LISTARVALIDACIONDATOS                    -- 
-- OBJETIVO        : RECUPERA LAS CONFIGURACIONES DE EMAIL, CELULAR Y TELÈFONO ACTUALES    -- 
-- VALORES PRUEBA    : LISTARVALIDACIONDATOS '04/04/2019', '17/04/2019', 'EMAIL', '043084550'          -- 
-- CREACION        : CGI(AAHA) 20190403                    --                  -- 
*/ 
CREATE PROCEDURE ListarValidacionDatos 
	@FECHAINICIO   VARCHAR(64), 
	@FECHAFIN      VARCHAR(64), 
	@TIPOENVIO     VARCHAR(32), 
	@CODIGOUSUARIO VARCHAR(32) 
AS 
BEGIN TRY 
    SET NOCOUNT ON 

    SELECT VALIDACIONID, 
            TIPOENVIO, 
            DATOANTIGUO, 
            DATONUEVO, 
            ESTADO, 
            CODIGOUSUARIO, 
            ISNULL(FECHACREACION, '')    FECHACREACION, 
            ISNULL(FECHAMODIFICACION, '')FECHAMODIFICACION, 
            IPDISPOSITIVO, 
            CASE 
            WHEN DISPOSITIVO = 1 THEN 'MOBILE' 
            ELSE 'DESKTOP' 
            END                          DESCRIPCIONDISPOSITIVO 
    FROM   VALIDACIONDATOS 
    WHERE  ( CASE 
                WHEN FECHAMODIFICACION IS NOT NULL THEN CAST( 
                FECHAMODIFICACION AS DATE) 
                ELSE CAST(FECHACREACION AS DATE) 
            END ) BETWEEN CAST(CONVERT(DATETIME, @FECHAINICIO, 104) AS DATE) 
                            AND 
                            CAST( 
                            CONVERT(DATETIME, @FECHAFIN, 104) AS DATE) 
            AND ( TIPOENVIO = @TIPOENVIO 
                OR '' = @TIPOENVIO ) 
            AND ( CODIGOUSUARIO = @CODIGOUSUARIO 
                OR '' = @CODIGOUSUARIO ) 
    ORDER  BY TIPOENVIO ASC, 
            DATOANTIGUO ASC, 
            DATONUEVO ASC, 
            ESTADO ASC, 
            CODIGOUSUARIO ASC, 
            FECHACREACION ASC 

    SET NOCOUNT OFF 
END TRY 

BEGIN CATCH 
    DECLARE @ERRORMESSAGE   VARCHAR(4000), 
            @ERRORNUMBER    INT, 
            @ERRORSEVERITY  INT, 
            @ERRORSTATE     INT, 
            @ERRORLINE      INT, 
            @ERRORPROCEDURE VARCHAR(200) 

    SELECT @ERRORNUMBER = ERROR_NUMBER(), 
            @ERRORSEVERITY = ERROR_SEVERITY(), 
            @ERRORSTATE = ERROR_STATE(), 
            @ERRORLINE = ERROR_LINE(), 
            @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-') 

    SELECT @ERRORMESSAGE = N'ERROR:%D|NIVEL%D|PROCEDIMIENTO %S|LINEA%D|' 
                            + 'MENSAJE: ' + ERROR_MESSAGE() 

    RAISERROR (@ERRORMESSAGE,@ERRORSEVERITY,1,@ERRORNUMBER,@ERRORSEVERITY, 
                @ERRORSTATE, 
                @ERRORPROCEDURE,@ERRORLINE) 
END CATCH
GO