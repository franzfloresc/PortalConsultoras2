USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopup]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 20/02/2019   
DESCRIPCIÓN : REGISTRA UN POPUP DE CONTENIDO 
*/ 
CREATE PROCEDURE [dbo].[GuardarPopup] 
@COMUNICADOID      INT, 
@TITULOPRINCIPAL   VARCHAR(128), 
@DESCRIPCION       VARCHAR(MAX), 
@DESCRIPCIONACCION VARCHAR(MAX), 
@URLIMAGEN         VARCHAR(MAX), 
@FECHAMAXIMA       VARCHAR(32), 
@FECHAMINIMA       VARCHAR(32), 
@TIPODISPOSITIVO   INT, 
@NOMBREARCHIVO     VARCHAR(128), 
@CODIGOCAMPANIA    VARCHAR(64), 
@ACCIONID          INT, 
@REGIONID          VARCHAR(MAX), 
@ZONAID            VARCHAR(MAX), 
@ESTADO            VARCHAR(MAX), 
@CODIGOCONSULTORA  VARCHAR(MAX) 
AS 
  BEGIN 
      /*CABECERA*/ 
      DECLARE @SEGMENTACIONID INT 
      DECLARE @ORDEN INT 
      DECLARE @SEGMENTACIONCONSULTORA INT 
      DECLARE @SEGMENTACIONREGIONZONA INT 
      DECLARE @SEGMENTACIONESTADOACTIVIDAD INT 
      DECLARE @IDENTITY INT 


      SELECT TOP 1 @ORDEN = ( ISNULL(ORDEN, 0) + 1 ) 
      FROM   COMUNICADO 
      ORDER  BY ORDEN DESC 

      IF ( @ACCIONID = 1 )  BEGIN /*NUEVO*/ 

	  	    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC 

            INSERT INTO COMUNICADO 
                        (FECHAREGISTRO, 
                         DESCRIPCION, 
                         ACTIVO, 
                         CODIGOCAMPANIA, 
                         ACCION, 
                         DESCRIPCIONACCION, 
                         SEGMENTACIONID, 
                         URLIMAGEN, 
                         ORDEN, 
                         FECHAINICIO, 
                         FECHAFIN, 
                         TIPODISPOSITIVO, 
                         SEGMENTACIONCONSULTORA, 
                         SEGMENTACIONREGIONZONA, 
                         SEGMENTACIONESTADOACTIVIDAD, 
                         NOMBREARCHIVOCCV, 
                         COMENTARIO) 
            VALUES      ( GETDATE(), 
                          @TITULOPRINCIPAL, 
                          1, 
                          @CODIGOCAMPANIA, 
                          'URL', 
                          @DESCRIPCIONACCION, 
                          CASE WHEN @REGIONID != '@' AND @ZONAID != '@' AND @ESTADO != '@'   AND @CODIGOCONSULTORA != '@' THEN @SEGMENTACIONID ELSE NULL END, 
                          @URLIMAGEN, 
                          @ORDEN, 
                          CAST(@FECHAMINIMA AS DATETIME), 
                          CAST(@FECHAMAXIMA AS DATETIME), 
                          @TIPODISPOSITIVO, 
                          NULL, 
                          NULL, 
                          NULL, 
                          CASE 
                            WHEN LEN(@NOMBREARCHIVO) > 0 THEN @NOMBREARCHIVO 
                            ELSE NULL 
                          END, 
                          @DESCRIPCION ) 

            SELECT @IDENTITY = SCOPE_IDENTITY() 

            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 
                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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
      ELSE 
        BEGIN 

            /*TABLA COMUNICADO*/ 
            UPDATE COMUNICADO 
            SET    DESCRIPCION = @TITULOPRINCIPAL, 
                   DESCRIPCIONACCION = @DESCRIPCIONACCION, 
                   URLIMAGEN = @URLIMAGEN, 
                   FECHAINICIO = @FECHAMINIMA, 
                   FECHAFIN = @FECHAMAXIMA, 
                   TIPODISPOSITIVO = @TIPODISPOSITIVO, 
                   NOMBREARCHIVOCCV = CASE 
                                        WHEN LEN(@NOMBREARCHIVO) > 0 THEN 
                                        @NOMBREARCHIVO 
                                        ELSE NULL 
                                      END, 
                   COMENTARIO = @DESCRIPCION 
            WHERE  COMUNICADOID = @COMUNICADOID 

            SELECT @IDENTITY = @COMUNICADOID 

        /*TABLA SEGMENATCIONCOMUNICADO*/ 
            /*TABLA SEGMENTACIÓN*/ 
            IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

			 IF( (SELECT ISNULL(SEGMENTACIONID,0) FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID)  > 0) BEGIN
			
			SELECT  @SEGMENTACIONID=SEGMENTACIONID
		    FROM    COMUNICADO  WHERE COMUNICADOID=@COMUNICADOID
			
			END
			ELSE
			BEGIN

		    SELECT TOP 1 @SEGMENTACIONID = ( ISNULL(SEGMENTACIONID, 0) + 1 ) 
		    FROM   COMUNICADO 
		    ORDER  BY SEGMENTACIONID DESC

			 UPDATE COMUNICADO SET SEGMENTACIONID=@SEGMENTACIONID
			 WHERE COMUNICADOID=@COMUNICADOID

			END



                  SELECT @SEGMENTACIONID = SEGMENTACIONID 
                  FROM   COMUNICADO 
                  WHERE  COMUNICADOID = @COMUNICADOID 

                  INSERT INTO [DBO].[SEGMENTACIONCOMUNICADO] 
                              (SEGMENTACIONID, 
                               CODIGOCONSULTORA, 
                               CODIGOREGION, 
                               CODIGOZONA, 
                               IDESTADOACTIVIDAD) 
                  SELECT @SEGMENTACIONID, 
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

      /*ACTUALIZAMOS LA ZONA, REGIÓN, SEGMENTACIÓN CONSULTORA*/ 
      SELECT @SEGMENTACIONCONSULTORA = CASE 
                                         WHEN CAST(CONSULTORA.VALOR AS INT) != 0 
                                       THEN 
                                         1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONREGIONZONA = CASE 
                                         WHEN CAST(REGION.VALOR AS INT) != 0 
                                               OR CAST(ZONA.VALOR AS INT) != 0 
                                       THEN 1 
                                         ELSE NULL 
                                       END, 
             @SEGMENTACIONESTADOACTIVIDAD = CASE 
                                              WHEN 
             CAST(ESTADO.VALOR AS INT) != 0 
                                            THEN 
                                              1 
                                              ELSE NULL 
                                            END 
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
                         FROM   DBO.SPLIT (@CODIGOCONSULTORA, '@')) CONSULTORA 
                     ON ESTADO.ID = CONSULTORA.ID 

        IF ( @REGIONID != '@' 
                 AND @ZONAID != '@' 
                 AND @ESTADO != '@' 
                 AND @CODIGOCONSULTORA != '@' ) 
              BEGIN 

      UPDATE COMUNICADO 
      SET    SEGMENTACIONCONSULTORA = @SEGMENTACIONCONSULTORA, 
             SEGMENTACIONREGIONZONA = @SEGMENTACIONREGIONZONA, 
             SEGMENTACIONESTADOACTIVIDAD = @SEGMENTACIONESTADOACTIVIDAD 
      WHERE  COMUNICADOID = @IDENTITY 

	  END
 
  END 

 
GO
