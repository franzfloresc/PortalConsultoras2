USE [BelcorpBolivia];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpChile];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpColombia];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpCostaRica];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpDominicana];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpEcuador];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpGuatemala];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpMexico];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpPanama];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpPeru];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpPuertoRico];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
USE [BelcorpSalvador];
GO
CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

SELECT  @TablaLogicaDatosID=TablaLogicaDatosID FROM TABLALOGICADATOS WHERE Codigo='9000'

/*ACTUALIZAMOS EL ESTADO DEL POPUP INFORMATICO*/
UPDATE TABLALOGICADATOS SET VALOR=@ESTADOVALIDADOR  WHERE TablaLogicaDatosID=@TablaLogicaDatosID

     IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			  DELETE FROM SEGMENTACIONCOMUNICADO WHERE SEGMENTACIONID=@TablaLogicaDatosID



                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @TablaLogicaDatosID, 
						 CASE WHEN  CAST(CONSULTORA.VALOR AS INT)=0 THEN  NULL ELSE CONSULTORA.VALOR  END CODIGOCONSULTORA, 
						 CASE WHEN  CAST(REGION.VALOR AS INT)=0 THEN NULL ELSE REGION.VALOR  END REGIONID, 
						 CASE WHEN  CAST(ZONA.VALOR AS INT)=0 THEN NULL ELSE ZONA.VALOR  END CODIGOZONAIDCONSULTORA, 
						 CASE WHEN  CAST(ESTADO.VALOR AS INT)=0 THEN NULL ELSE  ESTADO.VALOR   END ESTADO
                  FROM   (SELECT ROW_NUMBER() 
                                   OVER( 
                                     ORDER BY (SELECT 1)) AS ID, 
                                 VALOR 
                          FROM   DBO.SPLIT (@REGIONID, '@')) REGION 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ZONAID, '@')) ZONA 
                                 ON REGION.ID = ZONA.ID 
   INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@ESTADO, '@')) ESTADO 
                                 ON ZONA.ID = ESTADO.ID 
                         INNER JOIN (SELECT ROW_NUMBER() 
                                              OVER( 
                                                ORDER BY (SELECT 1)) AS ID, 
                                            VALOR 
                                     FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) 
                                    CONSULTORA 
                                 ON ESTADO.ID = CONSULTORA.ID 
              END 

END

GO
