USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetListadoPopup]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].GetListadoPopup
GO

CREATE  PROCEDURE [dbo].[GetListadoPopup] 
@CAMPANIA VARCHAR(64), 
@ACTIVO   INT, 
@PAGINAS  INT, 
@FILAS    INT 
AS 
    DECLARE @TOTALFILAS INT 
    DECLARE @PAGINASMAXIMAS INT 
    --SELECT @TOTALFILAS=COUNT(1) FROM DBO.COMUNICADO  
    DECLARE @TABLE AS TABLE 
      ( 
         NUMEROFILA        INT, 
         COMUNICADOID      INT, 
         URLIMAGEN         VARCHAR(128), 
         FECHAINICIO       VARCHAR(16), 
         FECHAFIN          VARCHAR(16), 
         TITULO            VARCHAR(128), 
         DESCRIPCIONACCION VARCHAR(MAX), 
         ACTIVO            BIT, 
         FECHAREGISTRO     VARCHAR(16), 
         ORDEN             INT 
      ) 

    /*ACTUALIZAMOS LOS ESTADOS EN BASE A LAS FECHAS YA PASADAS*/ 
    UPDATE C 
    SET    ACTIVO = 0 
    FROM   COMUNICADO C 
           INNER JOIN (SELECT * 
                       FROM   COMUNICADO 
                       WHERE  GETDATE() > FECHAFIN) T 
                   ON T.COMUNICADOID = C.COMUNICADOID 

  BEGIN 
      INSERT INTO @TABLE 
      SELECT ROW_NUMBER() 
               OVER( 
                 ORDER BY (SELECT 1))                                       AS 
             NUMEROFILA, 
             COMUNICADOID, 
             ISNULL(URLIMAGEN, '') 
             URLIMAGEN, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAINICIO AS DATE), 101), '') 
             FECHAINICIO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAFIN AS DATE), 101), '') 
             FECHAFIN, 
             ISNULL(DESCRIPCION, '') 
             TITULO 
             , 
             ISNULL(DESCRIPCIONACCION, '') 
             DESCRIPCIONACCION, 
             ACTIVO, 
             ISNULL(CONVERT(VARCHAR, CAST(FECHAREGISTRO AS DATE), 101), '') 
             FECHAREGISTRO, 
             ORDEN 
      FROM   DBO.COMUNICADO WITH(NOLOCK) 
      WHERE  ( CODIGOCAMPANIA = @CAMPANIA 
                OR ISNULL(@CAMPANIA, '') = '' ) 
             AND ACTIVO = ( CASE 
                              WHEN @ACTIVO = 2 THEN ACTIVO 
                              WHEN ( @ACTIVO = 1 
                                      OR @ACTIVO = 0 ) THEN CAST(@ACTIVO AS BIT) 
                            END ) 

      SELECT @TOTALFILAS = COUNT(1) 
      FROM   @TABLE 

      SELECT ORDEN NUMERO, 
             COMUNICADOID, 
             URLIMAGEN, 
             FECHAINICIO, 
             FECHAFIN, 
             TITULO, 
             DESCRIPCIONACCION, 
             ACTIVO, 
             CASE 
               WHEN @FILAS <= @TOTALFILAS THEN ( ( @TOTALFILAS / @FILAS ) + ( 
                                                 @TOTALFILAS%@FILAS ) ) 
               ELSE 1 
             END   PAGINASMAXIMAS, 
             NUMEROFILA 
      FROM   @TABLE 
      WHERE  NUMEROFILA BETWEEN ( @PAGINAS - 1 ) * @FILAS + 1 AND 
                                @PAGINAS * @FILAS 
      ORDER  BY NUMERO   
  END
GO
