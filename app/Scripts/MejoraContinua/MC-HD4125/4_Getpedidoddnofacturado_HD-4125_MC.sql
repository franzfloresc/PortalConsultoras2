/*  
MODIFICADO : 08052019, HD-4125, P.S.O  
MOTIVO : SE AGREG� UN FILTRO M�S DE INDICADORCONSULTORADIGITAL A LA CONSULTA Y EL RESULTADO  
GETPEDIDODDNOFACTURADO  

*/ 
ALTER PROCEDURE Getpedidoddnofacturado 
@CHRPREFIJOPAIS             CHAR(2), 
@CAMPANIAID                 CHAR(6), 
@REGIONCODIGO               VARCHAR(2) = NULL, 
@ZONACODIGO                 VARCHAR(6), 
@CODIGOCONSULTORA           VARCHAR(15), 
@FECHAREGISTROINICIO        DATE = NULL, 
@FECHAREGISTROFIN           DATE = NULL, 
@INDICADORCONSULTORADIGITAL INT= 2 
AS 
  BEGIN 
      SELECT P.PEDIDOID, 
             P.FECHAREGISTRO, 
             P.CAMPANIAID 
             AS 
             CAMPANIACODIGO, 
             Z.CODIGO 
             AS 
             ZONA 
             , 
             S.CODIGO 
             AS SECCION, 
             C.CODIGO 
             AS 
             CONSULTORACODIGO, 
             C.NOMBRECOMPLETO 
             AS 
             CONSULTORANOMBRE, 
             I.NUMERO 
             AS 
             DOCUMENTOIDENTIDAD, 
             P.IMPORTETOTAL, 
             P.CODIGOUSUARIOCREACION 
             AS 
             USUARIORESPONSABLE, 
             C.MONTOSALDOACTUAL 
             AS 
             CONSULTORASALDO, 
             'DD' 
             AS 
             ORIGENNOMBRE, 
             '' 
             AS 
             ESTADOVALIDACIONNOMBRE, 
             P.INDICADORENVIADO, 
             C.MONTOMINIMOPEDIDO, 
             ISNULL(DBO.FNOBTENERIMPORTEMM(P.CAMPANIAID, P.PEDIDOID, 'DD'), 0) 
             AS 
             IMPORTETOTALMM, 
             ISNULL(P.CODIGOUSUARIOMODIFICACION, P.CODIGOUSUARIOCREACION) 
             AS 
             USUARIORESPONSABLE, 
             R.CODIGO 
             REGION,
			 IIF(C.INDICADORCONSULTORADIGITAL = 1, 'SI', 'NO') INDICADORCONSULTORADIGITAL 
      FROM   DBO.PEDIDODD (NOLOCK) P 
             INNER JOIN ODS.CONSULTORA (NOLOCK) C 
                     ON P.CONSULTORAID = C.CONSULTORAID 
             INNER JOIN ODS.IDENTIFICACION (NOLOCK) I 
                     ON C.CONSULTORAID = I.CONSULTORAID 
                        AND I.DOCUMENTOPRINCIPAL = 1 
             INNER JOIN ODS.REGION (NOLOCK) R 
                     ON C.REGIONID = R.REGIONID 
             INNER JOIN ODS.ZONA (NOLOCK) Z 
                     ON C.ZONAID = Z.ZONAID 
             INNER JOIN ODS.SECCION (NOLOCK) S 
                     ON C.SECCIONID = S.SECCIONID 
      WHERE  P.INDICADORACTIVO = 1 
             AND P.CAMPANIAID = @CAMPANIAID 
             AND ( ISNULL(@ZONACODIGO, '0') = '0' 
                    OR Z.CODIGO = @ZONACODIGO ) 
             AND ( ISNULL(@REGIONCODIGO, '0') = '0' 
                    OR R.CODIGO = @REGIONCODIGO ) 
             AND ( ISNULL(@CODIGOCONSULTORA, '') = '' 
                    OR C.CODIGO LIKE '%' + @CODIGOCONSULTORA + '%' ) 
             AND ( @FECHAREGISTROINICIO IS NULL 
                    OR @FECHAREGISTROINICIO <= CONVERT(DATE, P.FECHAREGISTRO) ) 
             AND ( @FECHAREGISTROFIN IS NULL 
                    OR @FECHAREGISTROFIN >= CONVERT(DATE, P.FECHAREGISTRO) ) 
             AND ( ( C.INDICADORCONSULTORADIGITAL = @INDICADORCONSULTORADIGITAL 
                   ) 
                    OR ( @INDICADORCONSULTORADIGITAL = 2 ) ) 
  END 
  GO
