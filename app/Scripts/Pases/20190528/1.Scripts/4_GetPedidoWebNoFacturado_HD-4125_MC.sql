USE [BelcorpBolivia];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpChile];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpColombia];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpCostaRica];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpDominicana];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpEcuador];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpGuatemala];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpMexico];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpPanama];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpPeru];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpPuertoRico];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
USE [BelcorpSalvador];
GO
/* 
MODIFICADO : 08052019, HD-4125, P.S.O 
MOTIVO : SE AGREGÒ UN FILTRO MÀS DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO 
GETPEDIDOWEBNOFACTURADO 11, 201905, '10', NULL, NULL, 0, 0, NULL, NULL,1 
*/ 
ALTER PROCEDURE [DBO].[Getpedidowebnofacturado] 
@PAISID						INT, 
@CAMPANIAID					INT, 
@REGIONCODIGO				VARCHAR(8) = NULL, 
@ZONACODIGO					VARCHAR(8), 
@CODIGOCONSULTORA			VARCHAR(25), 
@ESTADOPEDIDO               INT, 
@ESRECHAZADO                INT = 0, 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      DECLARE @CAMPANIAV VARCHAR(10)= CONVERT(VARCHAR(10), @CAMPANIAID); 
      DECLARE @GPRSB TINYINT =2 
      DECLARE @PROCESADO BIT =1; 
      DECLARE @TIPODOCUMENTO VARCHAR(30)='1' 

      SELECT 
      --X.CONSULTORAID, 
      PEDIDOID, 
      FECHAREGISTRO, 
      FECHARESERVA, 
      CAMPANIACODIGO, 
      SECCION, 
      CONSULTORACODIGO, 
      CONSULTORANOMBRE, 
      IMPORTETOTAL, 
      DESCUENTOPROL, 
      CONSULTORASALDO, 
      ORIGENNOMBRE, 
      ESTADOVALIDACIONNOMBRE, 
      ZONA, 
      REGION, 
      NUMERO DOCUMENTOIDENTIDAD, 
      INDICADORENVIADO, 
      MONTOMINIMOPEDIDO, 
      IMPORTETOTALMM, 
      MOTIVORECHAZO, 
      ESTADOPEDIDO, 
      GPRSB, 
      INDICADORCONSULTORADIGITAL 
      FROM   (SELECT PEDIDOID, 
                     FECHAREGISTRO, 
                     FECHARESERVA, 
                     CAMPANIACODIGO, 
                     SECCION, 
                     CONSULTORACODIGO, 
                     CONSULTORANOMBRE, 
                     IMPORTETOTAL, 
                     DESCUENTOPROL, 
                     CONSULTORASALDO, 
                     ORIGENNOMBRE, 
                     ESTADOVALIDACIONNOMBRE, 
                     ZONA, 
                     REGION, 
                     INDICADORENVIADO, 
                     MONTOMINIMOPEDIDO, 
                     IMPORTETOTALMM, 
                     MOTIVORECHAZO, 
                     ESTADOPEDIDO, 
                     GPRSB, 
                     CONSULTORAID, 
                     INDICADORCONSULTORADIGITAL 
              FROM  (SELECT C.CONSULTORAID, 
                            IDPROCESORECHAZO.IDPROCESO, 
                            PR.IDPROCESOPEDIDORECHAZADO, 
                            P.PEDIDOID, 
                            P.FECHAREGISTRO 
                            FECHAREGISTRO, 
                            IIF(P.ESTADOPEDIDO = 202, P.FECHARESERVA, NULL) 
                            AS FECHARESERVA, 
                            P.CAMPANIAID CAMPANIACODIGO, 
                            S.CODIGO SECCION, 
                            C.CODIGO CONSULTORACODIGO, 
                            C.NOMBRECOMPLETO CONSULTORANOMBRE, 
                            P.IMPORTETOTAL, 
                            P.DESCUENTOPROL, 
                            C.MONTOSALDOACTUAL  CONSULTORASALDO, 
                            'WEB' ORIGENNOMBRE, 
                            IIF(P.ESTADOPEDIDO = 202 
                                AND P.VALIDACIONABIERTA = 0 
                                AND P.MODIFICAPEDIDORESERVADOMOVIL = 0, 'SI', 
                            'NO' 
                            )AS ESTADOVALIDACIONNOMBRE, 
                            Z.CODIGO AS ZONA, 
                            R.CODIGO AS REGION, 
                            --IDE.NUMERO AS DOCUMENTOIDENTIDAD, 
                            ISNULL(P.INDICADORENVIADO, 0) AS INDICADORENVIADO, 
                            C.MONTOMINIMOPEDIDO, 
                            0 AS IMPORTETOTALMM, 
                            ISNULL(P.CODIGOUSUARIOMODIFICACION, 
                            P.CODIGOUSUARIOCREACION) AS USUARIORESPONSABLE, 
                            CASE 
                              WHEN P.GPRSB IN( 1, 0 ) THEN '' 
                              ELSE ( STUFF((SELECT CAST(', ' + CASE MR.CODIGO 
                                                        WHEN 
                                                        'OCC-16' 
                                                        THEN 
                                                        'MÍNIMO: ' 
                                                        + 
                    CAST(C.MONTOMINIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-17' THEN 'MÁXIMO: ' + 
                    CAST(C.MONTOMAXIMOPEDIDO AS VARCHAR(15)) WHEN 'OCC-19' THEN 'DEUDA: ' + 
                    CAST(P1.VALOR AS VARCHAR(15)) 
                    WHEN 
                    'OCC-51' THEN 'MINIMO STOCK' END AS VARCHAR(MAX)) 
                    FROM   GPR.PEDIDORECHAZADO P1 
                    INNER JOIN GPR.MOTIVORECHAZO MR 
                    ON P1.MOTIVORECHAZO = MR.CODIGO 
                    WHERE  PR.IDPROCESOPEDIDORECHAZADO = 
                           P1.IDPROCESOPEDIDORECHAZADO 
                    AND P1.CODIGOCONSULTORA = PR.CODIGOCONSULTORA 
                    AND P1.CAMPANIA = PR.CAMPANIA 
                    AND 
                    --P.GPRSB = @GPRSB AND 
                    P1.PROCESADO = @PROCESADO 
                    AND P1.IDPROCESOPEDIDORECHAZADO = 
                    IDPROCESORECHAZO.IDPROCESO 
                    FOR XML PATH ('')), 1, 1, '') ) 
                    END AS MOTIVORECHAZO, 
                    P.ESTADOPEDIDO, 
                    P.GPRSB, 
                    IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') 
                                   INDICADORCONSULTORADIGITAL 
                     --PR.IDPEDIDORECHAZADO 
                     FROM   DBO.PEDIDOWEB P (NOLOCK) 
                            INNER JOIN ODS.CONSULTORA C (NOLOCK) 
                                    ON ( P.CONSULTORAID = C.CONSULTORAID ) 
                                       AND ( P.CAMPANIAID = @CAMPANIAID ) 
                            INNER JOIN ODS.ZONA Z (NOLOCK) 
                                    ON C.ZONAID = Z.ZONAID 
                            INNER JOIN ODS.REGION R (NOLOCK) 
                                    ON C.REGIONID = R.REGIONID 
                            INNER JOIN ODS.SECCION S (NOLOCK) 
                                    ON C.SECCIONID = S.SECCIONID 
                            LEFT JOIN GPR.PEDIDORECHAZADO PR (NOLOCK) 
                                   ON C.CODIGO = PR.CODIGOCONSULTORA 
                                      AND PR.CAMPANIA = @CAMPANIAV 
                                      AND PR.PROCESADO = @PROCESADO 
                            /* MOSTRAR SOLO 1 REGISTRO POR CONSULTORA.*/ 
                            LEFT JOIN (SELECT PR1.CODIGOCONSULTORA, 
                                              MAX(_PR.IDPROCESOPEDIDORECHAZADO) 
                                              IDPROCESO 
                                       FROM   GPR.PROCESOPEDIDORECHAZADO _PR 
                                              INNER JOIN GPR.PEDIDORECHAZADO PR1 
                                                      ON 
             _PR.IDPROCESOPEDIDORECHAZADO = PR1.IDPROCESOPEDIDORECHAZADO 
             AND PR1.CAMPANIA = @CAMPANIAV 
                        --WHERE PR1.CAMPANIA=@CAMPANIAV 
                        GROUP  BY PR1.CODIGOCONSULTORA) IDPROCESORECHAZO 
                    ON PR.IDPROCESOPEDIDORECHAZADO = 
                       IDPROCESORECHAZO.IDPROCESO 
                       AND IDPROCESORECHAZO.CODIGOCONSULTORA = C.CODIGO 
                       AND PR.CAMPANIA = @CAMPANIAV 
                     --INNER JOIN ODS.IDENTIFICACION IDE (NOLOCK) ON C.CONSULTORAID = IDE.CONSULTORAID AND IDE.DOCUMENTOPRINCIPAL = 1
                     WHERE  P.IMPORTETOTAL <> 0 
                            AND ( @ESRECHAZADO = 2 
                                   OR ( @ESRECHAZADO = 1 
                                        AND P.GPRSB = 2 ) 
                                   OR ( @ESRECHAZADO = 0 
                                        AND P.GPRSB <> 2 ) ) 
                            AND ( @ESTADOPEDIDO = 0 
                                   OR @ESTADOPEDIDO = 
                                      IIF(P.ESTADOPEDIDO = 202 
                                          AND P.VALIDACIONABIERTA = 0 
                                          AND P.MODIFICAPEDIDORESERVADOMOVIL 
                                              = 0, 
                                      202, 201) 
                                ) 
                            AND ( @ZONACODIGO IS NULL 
                                   OR ( Z.CODIGO = @ZONACODIGO ) ) 
                            AND ( @REGIONCODIGO IS NULL 
                                   OR ( R.CODIGO = @REGIONCODIGO ) ) 
                            AND ( ( @CODIGOCONSULTORA IS NULL ) 
                                   OR ( C.CODIGO = @CODIGOCONSULTORA ) ) 
                            AND ( @FECHAREGISTROINICIO IS NULL 
                                   OR @FECHAREGISTROINICIO <= CONVERT(DATE, 
                                P.FECHAREGISTRO) ) 
                            AND ( @FECHAREGISTROFIN IS NULL 
                                   OR @FECHAREGISTROFIN >= 
                                      CONVERT(DATE, P.FECHAREGISTRO) ) 
                            AND ( ( 
                    C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL ) 
                                   OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
                    --AND PR.PROCESADO=1 
                    ) T 
              WHERE  MOTIVORECHAZO IS NOT NULL) X 
             INNER JOIN ODS.IDENTIFICACION IDE 
                     ON X.CONSULTORAID = IDE.CONSULTORAID 
                        AND IDE.DOCUMENTOPRINCIPAL = @TIPODOCUMENTO 
      GROUP  BY PEDIDOID, 
                FECHAREGISTRO, 
                FECHARESERVA, 
                CAMPANIACODIGO, 
                SECCION, 
                CONSULTORACODIGO, 
                CONSULTORANOMBRE, 
                IMPORTETOTAL, 
                DESCUENTOPROL, 
                CONSULTORASALDO, 
                ORIGENNOMBRE, 
                ESTADOVALIDACIONNOMBRE, 
                ZONA, 
                REGION, 
                IDE.NUMERO, 
                INDICADORENVIADO, 
                MONTOMINIMOPEDIDO, 
                IMPORTETOTALMM, 
                MOTIVORECHAZO, 
                ESTADOPEDIDO, 
                GPRSB, 
                INDICADORCONSULTORADIGITAL 
      ORDER  BY FECHAREGISTRO 
  --  OPTION  (OPTIMIZE FOR (@ESRECHAZADO = 2,@ESTADOPEDIDO=0,@ZONACODIGO=NULL,@REGIONCODIGO=NULL,@CODIGOCONSULTORA=NULL,@FECHAREGISTROINICIO=NULL,@FECHAREGISTROFIN=NULL)) 
  --OPTION  (RECOMPILE) 
  END 

GO 
GO
