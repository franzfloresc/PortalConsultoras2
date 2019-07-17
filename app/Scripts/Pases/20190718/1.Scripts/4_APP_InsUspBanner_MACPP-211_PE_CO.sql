USE BelcorpPeru
GO

ALTER PROCEDURE Insupdbanner
@CAMPANIAID          INT, 
@BANNERID            INT, 
@GRUPOBANNERID       INT, 
@ORDEN               INT, 
@TITULO              VARCHAR(50), 
@ARCHIVO             VARCHAR(200), 
@URL                 VARCHAR(300), 
@FLAGGRUPOCONSULTORA BIT, 
@FLAGCONSULTORANUEVA BIT, 
@BANNERIDOUT         INT OUTPUT, 
@PAISES              DBO.LISTOFVALUES READONLY, 
@UDPSOLOBANNER       BIT = 0, 
@TIPOCONTENIDO       INT, 
@PAGINANUEVA         INT, 
@TITULOCOMENTARIO    VARCHAR(120) = NULL, 
@TEXTOCOMENTARIO     VARCHAR(120) = NULL, 
@TIPOACCION          INT, 
@CUVPEDIDO           VARCHAR(50) = NULL, 
@CANTCUVPEDIDO       INT, 
@ARCHIVOMOBILE       VARCHAR(200)=NULL, 
@URLMOBILE           VARCHAR(300)=NULL
AS 
  BEGIN TRY 
      BEGIN TRAN 

      IF (SELECT COUNT(*) 
          WHERE  @URL LIKE '%HTTPS://WWW.SOMOSBELCORP.COM/SUPERATE/INDEX?URL=%') 
         = 
         1 
        SET @URL = REPLACE(@URL, '&', '*') 

      IF(SELECT COUNT(*) 
         FROM   [DBO].[GRUPOBANNER] 
         WHERE  [CAMPANIAID] = @CAMPANIAID 
                AND [GRUPOBANNERID] = @GRUPOBANNERID) = 0 
        INSERT INTO [DBO].[GRUPOBANNER] 
                    (CAMPANIAID, 
                     GRUPOBANNERID, 
                     TIEMPOROTACION) 
        VALUES      (@CAMPANIAID, 
                     @GRUPOBANNERID, 
                     1) 

      IF @BANNERID = 0 
        BEGIN 
            SELECT @BANNERID = COALESCE(MAX(BANNERID), 0) + 1 
            FROM   DBO.BANNER 
            WHERE  CAMPANIAID = @CAMPANIAID 

            INSERT INTO DBO.BANNER 
                        (CAMPANIAID, 
                         BANNERID, 
                         GRUPOBANNERID, 
                         ORDEN, 
                         TITULO, 
                         ARCHIVO, 
                         URL, 
                         FLAGGRUPOCONSULTORA, 
                         FLAGCONSULTORANUEVA, 
                         TIPOCONTENIDO, 
                         PAGINANUEVA, 
                         TITULOCOMENTARIO, 
                         TEXTOCOMENTARIO, 
                         TIPOACCION, 
                         CUVPEDIDO, 
                         CANTCUVPEDIDO, 
                         ARCHIVOMOBILE, 
                         URLMOBILE) 
            VALUES      (@CAMPANIAID, 
                         @BANNERID, 
                         @GRUPOBANNERID, 
                         @ORDEN, 
                         @TITULO, 
                         @ARCHIVO, 
                         @URL, 
                         @FLAGGRUPOCONSULTORA, 
                         @FLAGCONSULTORANUEVA, 
                         @TIPOCONTENIDO, 
                         @PAGINANUEVA, 
                         @TITULOCOMENTARIO, 
                         @TEXTOCOMENTARIO, 
                         @TIPOACCION, 
                         @CUVPEDIDO, 
                         @CANTCUVPEDIDO, 
                         @ARCHIVOMOBILE, 
                         @URLMOBILE) 
        END 
      ELSE 
        BEGIN 
            UPDATE DBO.BANNER 
            SET    GRUPOBANNERID = @GRUPOBANNERID, 
                   /*ORDEN = @ORDEN,*/ TITULO = @TITULO, 
                   ARCHIVO = @ARCHIVO, 
                   URL = @URL, 
                   FLAGGRUPOCONSULTORA = @FLAGGRUPOCONSULTORA, 
                   FLAGCONSULTORANUEVA = @FLAGCONSULTORANUEVA, 
                   TIPOCONTENIDO = @TIPOCONTENIDO, 
                   PAGINANUEVA = @PAGINANUEVA, 
                   TITULOCOMENTARIO = @TITULOCOMENTARIO, 
                   TEXTOCOMENTARIO = @TEXTOCOMENTARIO, 
                   TIPOACCION = @TIPOACCION, 
                   CUVPEDIDO = @CUVPEDIDO, 
    CANTCUVPEDIDO = @CANTCUVPEDIDO, 
                   ARCHIVOMOBILE = @ARCHIVOMOBILE, 
                   URLMOBILE = @URLMOBILE 
            WHERE  CAMPANIAID = @CAMPANIAID 
                   AND BANNERID = @BANNERID 

            IF @UDPSOLOBANNER = 0 
              BEGIN 
                  DELETE DBO.BANNERPAIS 
                  WHERE  CAMPANIAID = @CAMPANIAID 
                         AND BANNERID = @BANNERID 
              END 
        END 

      IF @UDPSOLOBANNER = 0 
        BEGIN 
            INSERT INTO DBO.BANNERPAIS 
                        (CAMPANIAID, 
                         BANNERID, 
                         PAISID) 
            SELECT @CAMPANIAID, 
                   @BANNERID, 
                   CAST(VALUE AS TINYINT) 
            FROM   @PAISES 
        END 

      SET @BANNERIDOUT = @BANNERID 

      COMMIT TRAN 
  END TRY 

  BEGIN CATCH 
      ROLLBACK TRAN 

      THROW 
  END CATCH 

GO

USE BelcorpColombia
GO

ALTER PROCEDURE Insupdbanner
@CAMPANIAID          INT, 
@BANNERID            INT, 
@GRUPOBANNERID       INT, 
@ORDEN               INT, 
@TITULO              VARCHAR(50), 
@ARCHIVO             VARCHAR(200), 
@URL                 VARCHAR(300), 
@FLAGGRUPOCONSULTORA BIT, 
@FLAGCONSULTORANUEVA BIT, 
@BANNERIDOUT         INT OUTPUT, 
@PAISES              DBO.LISTOFVALUES READONLY, 
@UDPSOLOBANNER       BIT = 0, 
@TIPOCONTENIDO       INT, 
@PAGINANUEVA         INT, 
@TITULOCOMENTARIO    VARCHAR(120) = NULL, 
@TEXTOCOMENTARIO     VARCHAR(120) = NULL, 
@TIPOACCION          INT, 
@CUVPEDIDO           VARCHAR(50) = NULL, 
@CANTCUVPEDIDO       INT, 
@ARCHIVOMOBILE       VARCHAR(200)=NULL, 
@URLMOBILE           VARCHAR(300)=NULL
AS 
  BEGIN TRY 
      BEGIN TRAN 

      IF (SELECT COUNT(*) 
          WHERE  @URL LIKE '%HTTPS://WWW.SOMOSBELCORP.COM/SUPERATE/INDEX?URL=%') 
         = 
         1 
        SET @URL = REPLACE(@URL, '&', '*') 

      IF(SELECT COUNT(*) 
         FROM   [DBO].[GRUPOBANNER] 
         WHERE  [CAMPANIAID] = @CAMPANIAID 
                AND [GRUPOBANNERID] = @GRUPOBANNERID) = 0 
        INSERT INTO [DBO].[GRUPOBANNER] 
                    (CAMPANIAID, 
                     GRUPOBANNERID, 
                     TIEMPOROTACION) 
        VALUES      (@CAMPANIAID, 
                     @GRUPOBANNERID, 
                     1) 

      IF @BANNERID = 0 
        BEGIN 
            SELECT @BANNERID = COALESCE(MAX(BANNERID), 0) + 1 
            FROM   DBO.BANNER 
            WHERE  CAMPANIAID = @CAMPANIAID 

            INSERT INTO DBO.BANNER 
                        (CAMPANIAID, 
                         BANNERID, 
                         GRUPOBANNERID, 
                         ORDEN, 
                         TITULO, 
                         ARCHIVO, 
                         URL, 
                         FLAGGRUPOCONSULTORA, 
                         FLAGCONSULTORANUEVA, 
                         TIPOCONTENIDO, 
                         PAGINANUEVA, 
                         TITULOCOMENTARIO, 
                         TEXTOCOMENTARIO, 
                         TIPOACCION, 
                         CUVPEDIDO, 
                         CANTCUVPEDIDO, 
                         ARCHIVOMOBILE, 
                         URLMOBILE) 
            VALUES      (@CAMPANIAID, 
                         @BANNERID, 
                         @GRUPOBANNERID, 
                         @ORDEN, 
                         @TITULO, 
                         @ARCHIVO, 
                         @URL, 
                         @FLAGGRUPOCONSULTORA, 
                         @FLAGCONSULTORANUEVA, 
                         @TIPOCONTENIDO, 
                         @PAGINANUEVA, 
                         @TITULOCOMENTARIO, 
                         @TEXTOCOMENTARIO, 
                         @TIPOACCION, 
                         @CUVPEDIDO, 
                         @CANTCUVPEDIDO, 
                         @ARCHIVOMOBILE, 
                         @URLMOBILE) 
        END 
      ELSE 
        BEGIN 
            UPDATE DBO.BANNER 
            SET    GRUPOBANNERID = @GRUPOBANNERID, 
                   /*ORDEN = @ORDEN,*/ TITULO = @TITULO, 
                   ARCHIVO = @ARCHIVO, 
                   URL = @URL, 
                   FLAGGRUPOCONSULTORA = @FLAGGRUPOCONSULTORA, 
                   FLAGCONSULTORANUEVA = @FLAGCONSULTORANUEVA, 
                   TIPOCONTENIDO = @TIPOCONTENIDO, 
                   PAGINANUEVA = @PAGINANUEVA, 
                   TITULOCOMENTARIO = @TITULOCOMENTARIO, 
                   TEXTOCOMENTARIO = @TEXTOCOMENTARIO, 
                   TIPOACCION = @TIPOACCION, 
                   CUVPEDIDO = @CUVPEDIDO, 
    CANTCUVPEDIDO = @CANTCUVPEDIDO, 
                   ARCHIVOMOBILE = @ARCHIVOMOBILE, 
                   URLMOBILE = @URLMOBILE 
            WHERE  CAMPANIAID = @CAMPANIAID 
                   AND BANNERID = @BANNERID 

            IF @UDPSOLOBANNER = 0 
              BEGIN 
                  DELETE DBO.BANNERPAIS 
                  WHERE  CAMPANIAID = @CAMPANIAID 
                         AND BANNERID = @BANNERID 
              END 
        END 

      IF @UDPSOLOBANNER = 0 
        BEGIN 
            INSERT INTO DBO.BANNERPAIS 
                        (CAMPANIAID, 
                         BANNERID, 
                         PAISID) 
            SELECT @CAMPANIAID, 
                   @BANNERID, 
                   CAST(VALUE AS TINYINT) 
            FROM   @PAISES 
        END 

      SET @BANNERIDOUT = @BANNERID 

      COMMIT TRAN 
  END TRY 

  BEGIN CATCH 
      ROLLBACK TRAN 

      THROW 
  END CATCH 

GO

