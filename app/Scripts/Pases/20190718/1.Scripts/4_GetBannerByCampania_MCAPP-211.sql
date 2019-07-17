USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           REPLACE(BAN.URL, '*', '&')                         URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           ISNULL(BAN.TITULOCOMENTARIO, '')                   TITULOCOMENTARIO, 
           ISNULL(BAN.TEXTOCOMENTARIO, '')                    TEXTOCOMENTARIO, 
           ISNULL(BAN.CUVPEDIDO, '')                          CUVPEDIDO, 
           ISNULL(BAN.CANTCUVPEDIDO, '')                      CANTCUVPEDIDO, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE, 
           BAN.ARCHIVOMOBILE, 
           BAN.URLMOBILE 
    FROM   DBO.BANNER BAN WITH(NOLOCK) 
           LEFT JOIN GRUPOBANNER GBAN WITH(NOLOCK) 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BP.BANNERID, 
           BP.PAISID, 
           ISNULL(SEGMENTO, -1)          AS SEGMENTO, 
           ISNULL(CONFIGURACIONZONA, '') AS CONFIGURACIONZONA 
    FROM   DBO.BANNERPAIS BP WITH(NOLOCK) 
           LEFT JOIN DBO.BANNERPAISSEGMENTOZONA BPSZ WITH(NOLOCK) 
                  ON BP.CAMPANIAID = BPSZ.CAMPANIAID 
                     AND BP.BANNERID = BPSZ.BANNERID 
                     AND BP.PAISID = BPSZ.PAISID 
    WHERE  BP.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BP.BANNERID, 
              BP.PAISID 
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO
 
CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[Getbannerbycampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[Getbannerbycampania]
GO

CREATE PROC [dbo].[Getbannerbycampania] 
@CAMPANIAID INT 
AS 
    SELECT BAN.CAMPANIAID, 
           BAN.BANNERID, 
           BAN.GRUPOBANNERID, 
           BAN.ORDEN, 
           BAN.TITULO, 
           BAN.ARCHIVO, 
           BAN.URL, 
           BAN.FLAGGRUPOCONSULTORA, 
           BAN.FLAGCONSULTORANUEVA, 
           ISNULL(GBAN.TIEMPOROTACION, 0)                     TIEMPOROTACION, 
           ISNULL(BAN.TIPOCONTENIDO, 0)                       TIPOCONTENIDO, 
           ISNULL(BAN.TIPOACCION, 0)                          TIPOACCION, 
           ISNULL(BAN.PAGINANUEVA, 1)                         PAGINANUEVA, 
           (SELECT NOMBRE 
            FROM   GRUPOBANNERBASE GBBASE 
            WHERE  GBBASE.GRUPOBANNERID = GBAN.GRUPOBANNERID) NOMBRE,
		   BAN.ARCHIVOMOBILE, /*HD-4144*/
           BAN.URLMOBILE /*HD-4144*/
    FROM   DBO.BANNER BAN 
           LEFT JOIN GRUPOBANNER GBAN 
                  ON BAN.CAMPANIAID = GBAN.CAMPANIAID 
                     AND BAN.GRUPOBANNERID = GBAN.GRUPOBANNERID 
    WHERE  BAN.CAMPANIAID = @CAMPANIAID 
    ORDER  BY BAN.BANNERID 

    SELECT BANNERID, 
           PAISID 
    FROM   DBO.BANNERPAIS 
    WHERE  CAMPANIAID = @CAMPANIAID 
    ORDER  BY BANNERID, 
              PAISID 

GO

