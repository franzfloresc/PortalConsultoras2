USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : ACTUALIZA LA CONFIGURACIÒN DEL POPUP VALIDADOR REGISTRANDO O ACTUALIZANDO 
select Valor FROM TABLALOGICADATOS  WHERE TablaLogicaDatosID=@TablaLogicaDatosID
*/ 

CREATE PROCEDURE [dbo].[GuardarPopupsValidador] 
@ESTADOVALIDADOR   VARCHAR(128), 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(8), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
BEGIN
DECLARE @TablaLogicaDatosID  INT

      SELECT  @TablaLogicaDatosID=TABLALOGICADATOSID 
      FROM   TABLALOGICADATOS 
      WHERE  TablaLogicaID=171

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
	
GO
