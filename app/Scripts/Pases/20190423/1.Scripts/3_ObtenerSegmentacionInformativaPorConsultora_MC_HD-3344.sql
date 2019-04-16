USE [BelcorpBolivia];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpChile];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpColombia];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpCostaRica];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpDominicana];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpEcuador];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpGuatemala];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpMexico];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpPanama];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpPeru];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpPuertoRico];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
USE [BelcorpSalvador];
GO
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT @TABLALOGICADATOSID = TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  CODIGO = '9000' 

      SELECT @SEGMENTACIONID = CASE 
                                 WHEN (SELECT COUNT(1) 
                                       FROM   DBO.SEGMENTACIONCOMUNICADO 
                                       WHERE  SEGMENTACIONID = 
                                              @TABLALOGICADATOSID 
                                      ) > 
                                      0 THEN 
                                 1 
                                 ELSE NULL 
                               END 

      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND CODIGOCONSULTORA IS 
                                                          NOT 
                                                          NULL 
                                              ) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN (SELECT COUNT(1) 
                                               FROM   DBO.SEGMENTACIONCOMUNICADO 
                                               WHERE  SEGMENTACIONID = 
                                                      @TABLALOGICADATOSID 
                                                      AND ( CODIGOREGION IS NOT 
                                                            NULL 
                                                             OR CODIGOZONA IS 
                                                                NOT 
                                                                NULL 
                                                          )) > 0 
                                              THEN 1 
                                         ELSE 0 
                                       END 

      SELECT @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             (SELECT COUNT(1) 
              FROM   DBO.SEGMENTACIONCOMUNICADO 
              WHERE  SEGMENTACIONID = 
                     @TABLALOGICADATOSID 
                     AND IDESTADOACTIVIDAD IS 
                         NOT NULL) 
             > 0 THEN 1 
                                              ELSE 0 
                                            END 

      SELECT 0                                         COMUNICADOID, 
             '0'                                       CODIGOCONSULTORA, 
             NULL                                      CODIGOCAMPANIA, 
             ''                                        ACCION, 
             ''                                        DESCRIPCIONACCION, 
             ''                                        URLIMAGEN, 
             CAST(0 AS BIT)                            VISUALIZO, 
             0                                         ORDEN, 
             ''                                        DESCRIPCION, 
             @SEGMENTACIONID                           SEGMENTACIONID, 
             CAST(@SEGMENTACIONCONSULTORA AS BIT)      SEGMENTACIONCONSULTORA, 
             CAST(@SEGMENTACIONREGIONZONA AS BIT)      SEGMENTACIONREGIONZONA, 
             CAST(@SEGMENTACIONESTADOACTIVIDAD AS BIT) 
             SEGMENTACIONESTADOACTIVIDAD 

      SELECT SC.SEGMENTACIONCOMUNICADOID, 
             SC.SEGMENTACIONID, 
             SC.CODIGOCONSULTORA, 
             SC.CODIGOREGION, 
             SC.CODIGOZONA, 
             SC.IDESTADOACTIVIDAD 
      FROM   DBO.SEGMENTACIONCOMUNICADO SC(NOLOCK) 
      WHERE  SC.SEGMENTACIONID = @TABLALOGICADATOSID 

      SET NOCOUNT OFF 
  END 

GO
