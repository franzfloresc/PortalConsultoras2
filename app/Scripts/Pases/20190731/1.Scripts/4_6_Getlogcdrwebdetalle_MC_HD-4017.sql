USE BELCORPBOLIVIA
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpChile
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpColombia
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpCostaRica
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpDominicana
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpEcuador 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpGuatemala
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpMexico
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpPanama 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpPeru 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpPuertoRico
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 


USE BelcorpSalvador
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[Getlogcdrwebdetalle]
@LOGCDRWEBID BIGINT 
AS 
  BEGIN 
      INSERT INTO INTERFACES.LOGCDRWEBDETALLE 
                  (LOGCDRWEBID, 
                   CDRWEBDETALLEID, 
                   CODIGOOPERACIONCDR, 
                   CODIGOMOTIVOCDR, 
                   CUV, 
                   CANTIDAD, 
                   PEDIDOID, 
                   CUV2, 
                   CANTIDAD2, 
                   DETALLEREEMPLAZO)  /*HD-4017*/
      SELECT @LOGCDRWEBID, 
             CDRWD.CDRWEBDETALLEID, 
             CDRWD.CODIGOOPERACION, 
             CDRWD.CODIGORECLAMO, 
             CDRWD.CUV, 
             CDRWD.CANTIDAD, 
             LCDRW.PEDIDOID, 
             CDRWD.CUV2, 
             CDRWD.CANTIDAD2, 
             CDRWD.DETALLEREEMPLAZO /*HD-4017*/
      FROM   LOGCDRWEB LCDRW 
             INNER JOIN CDRWEBDETALLE CDRWD 
                     ON CDRWD.CDRWEBID = LCDRW.CDRWEBID 
      WHERE  LCDRW.LOGCDRWEBID = @LOGCDRWEBID 
             AND CDRWD.ELIMINADO = 0; 

      SELECT CD.LOGCDRWEBDETALLEID, 
             CD.CDRWEBDETALLEID, 
             CD.LOGCDRWEBID, 
             CD.PEDIDOID, 
             C.CDRWEBID                  AS CDRWEBID, 
             CD.CODIGOOPERACIONCDR, 
             CD.CODIGOMOTIVOCDR, 
             CD.CUV, 
             CD.CANTIDAD, 
             ISNULL(CD.CUV2, '')         AS CUV2, 
             CD.CANTIDAD2                AS CANTIDAD2, 
             CD.ESTADOCDR, 
             CD.CODIGORECHAZO, 
             CD.OBSERVACIONRECHAZO, 
             PC.DESCRIPCION              AS NOMBREPRODUCTO, 
             ISNULL(PC2.DESCRIPCION, '') AS NOMBREPRODUCTO2, 
             CASE 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PWD.PRECIOUNIDAD * PWD.FACTORREPETICION * CD.CANTIDAD ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO, 
             CASE 
               WHEN ISNULL(CD.CUV2, '') = '' THEN 0 
               WHEN CD.CODIGOOPERACIONCDR = LTRIM(RTRIM('T')) THEN ( 
               PC2.PRECIOCATALOGO * PC2.FACTORREPETICION * CD.CANTIDAD2 ) 
               ELSE ( PWD.MONTOPAGAR * CD.CANTIDAD / PWD.CANTIDAD ) 
             END                         AS PRECIO2, 
             CD.DETALLEREEMPLAZO  /*HD-4017*/
      FROM   INTERFACES.LOGCDRWEB C 
             INNER JOIN INTERFACES.LOGCDRWEBDETALLE CD 
                     ON C.LOGCDRWEBID = CD.LOGCDRWEBID 
             INNER JOIN ODS.CAMPANIA CA 
                     ON C.CAMPANIAID = CA.CODIGO 
             INNER JOIN ODS.PRODUCTOCOMERCIAL PC 
                     ON CD.CUV = PC.CUV 
                        AND PC.ANOCAMPANIA = C.CAMPANIAID 
             LEFT JOIN ODS.PRODUCTOCOMERCIAL PC2 
                    ON CD.CUV2 = PC2.CUV 
                       AND PC2.ANOCAMPANIA = C.CAMPANIAID 
             INNER JOIN ODS.PEDIDODETALLE PWD 
                     ON PWD.CUV = CD.CUV 
                        AND PWD.PEDIDOID = CD.PEDIDOID 
      WHERE  C.LOGCDRWEBID = @LOGCDRWEBID; 
  END 

GO 