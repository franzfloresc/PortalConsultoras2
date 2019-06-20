USE [BelcorpBolivia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpChile];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpColombia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpCostaRica];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpDominicana];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpEcuador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpGuatemala];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpMexico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpPanama];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpPeru];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpPuertoRico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
USE [BelcorpSalvador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[Obtenersegmentacioninformativaporconsultora]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[Obtenersegmentacioninformativaporconsultora]
GO
/*
-- Nombre				: Obtenersegmentacioninformativaporconsultora									 
-- Objetivo				: Retorna las configuraciones para la vista del popup informativo
-- Creacion				: P.S.O HD-3680 MC 20190416									  							  
*/
CREATE PROCEDURE DBO.Obtenersegmentacioninformativaporconsultora 
AS 
  BEGIN 
      SET NOCOUNT ON 

      DECLARE @TABLALOGICADATOSID INT 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 

      SELECT  @TABLALOGICADATOSID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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

GO
