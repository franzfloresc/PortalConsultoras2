USE [BelcorpBolivia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpChile];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpColombia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpCostaRica];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpDominicana];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpEcuador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpGuatemala];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpMexico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpPanama];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpPeru];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpPuertoRico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
USE [BelcorpSalvador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO


CREATE PROCEDURE [dbo].[ActualizaOrden] 
@COMUNICADO VARCHAR(MAX), 
@ORDEN      VARCHAR(MAX) 
AS 
  BEGIN 
      UPDATE C 
      SET    ORDEN = ORDEN.VALOR 
      FROM   COMUNICADO C 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@COMUNICADO, '#')) CODIGOSCOMUNICADO 
                     ON C.COMUNICADOID = CODIGOSCOMUNICADO.VALOR 
             INNER JOIN (SELECT ROW_NUMBER() 
                                  OVER( 
                                    ORDER BY (SELECT 1)) AS ID, 
                                VALOR 
                         FROM   DBO.SPLIT (@ORDEN, '#'))ORDEN 
                     ON CODIGOSCOMUNICADO.ID = ORDEN.ID 
      WHERE  C.COMUNICADOID IN (SELECT VALOR 
                                FROM   DBO.SPLIT(@COMUNICADO, '#')) 
  END 


GO
