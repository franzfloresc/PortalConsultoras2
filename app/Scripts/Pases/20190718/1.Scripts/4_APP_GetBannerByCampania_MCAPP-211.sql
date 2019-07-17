﻿USE BelcorpMexico
GO

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

/*    
CREADO POR  : PAQUIRRI SEPERAK    
FECHA : 20190520  
DESCRIPCIÓN : SE AGREGARON 2 CAMPOS MÁS ARCHIVOMOBILE,URLMOBILE, ESTOS CAMPOS SERÁN USADOS POR EL APP SOLAMENTE 
Getbannerbycampania  201907
*/ 
ALTER PROC [dbo].[Getbannerbycampania] 
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

