USE [BelcorpBolivia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpChile];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpColombia];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpCostaRica];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpDominicana];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpEcuador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpGuatemala];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpMexico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpPanama];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpPeru];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpPuertoRico];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
USE [BelcorpSalvador];
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]
GO
/*      
CREADO POR  : PAQUIRRI SEPERAK      
FECHA : 20/02/2019   
FECHA MODIFICACIÓN : 10/06/2019    
DESCRIPCIÓN :RETORNA UN REPORTE DE CONSULTORAS DONDE MUESTRAN LA VENTA SUGERIDA Y DIGITADA   
*/ 
CREATE PROC [DBO].[GETPRODUCTOSUGERIDOBYCAMPANIANIVELCONSULTORA]  
( 
 @LISTCAMPANIAS VARCHAR(MAX)

)  
AS 
BEGIN 
    DECLARE @ISOPAIS AS VARCHAR(2) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS*/ 
    DECLARE @TB_RESULTADOS_DIGITADOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         CUVSUGERIDO                       VARCHAR(36) 
      ) 
    /*EN ESTA TABLA SE CARGARÁN LOS PRODUCTOS DIGITADOS Y SUGERIDOS*/ 
    DECLARE @TB_RESULTADOS_SUGERIDOS_PEDIDO AS TABLE 
      ( 
         ID                                INT IDENTITY PRIMARY KEY, 
         PAIS                              VARCHAR(32), 
         CAMPANIA                          VARCHAR(32), 
         CONSULTORAID                      INT, 
         CODIGOCONSULTORA                  VARCHAR(32), 
         CONSULTORA                        VARCHAR(1024), 
         REGION                            VARCHAR(256), 
         ZONA                              VARCHAR(256), 
         EDAD                              INT, 
         PRODUCTODIGITADO                  VARCHAR(1024), 
         MARCA                             VARCHAR(128), 
         CATEGORIA                         VARCHAR(128), 
         PRODUCTOSUGERIDO                  VARCHAR(1024), 
         MARCASUGERIDO                     VARCHAR(128), 
         CATEGORIASUGERIDO                 VARCHAR(128), 
         CANTIDAD                          INT, 
         CANTIDADFACTURO                   INT, 
         ACEPTOSUGERIDO                    CHAR(2), 
         FECHAFACTURADO                    VARCHAR(128), 
         ESTADOSUGERIDO                    INT, 
         PEDIDOID                          INT, 
         IPUSUARIO                         VARCHAR(64), 
         CODIGOSTATUS                      VARCHAR(64), 
         DESCRIPCIONTIPODIGITADO           VARCHAR(128), 
         ESBRILLANTE                       CHAR(16), 
         ESTADOACTIVIDAD                   VARCHAR(128), 
         DESCRIPCIONTIPOSUGERIDO           VARCHAR(128), 
         PRECIODIGITADO                    MONEY, 
         PRECIOSUGERIDO                    MONEY, 
         CODIGOFORMAVENTA                  VARCHAR(64), 
         DESCRIPCIONFORMAVENTA             VARCHAR(256), 
         CODIGOTIPOOFERTA                  VARCHAR(16), 
         DESCRIPCIONTIPOOFERTA             VARCHAR(128), 
         CUCDIGITADO                       VARCHAR(16), 
         DESCRIPCIONCUCDIGITADO            VARCHAR(128), 
         CODIGOGENERICODIGITADO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICODIGITADO VARCHAR(128), 
         CUCSUGERIDO                       VARCHAR(16), 
         DESCRIPCIONCUCSUGERIDO            VARCHAR(128), 
         CODIGOGENERICOSUGERIDO            VARCHAR(16), 
         DESCRIPCIONCODIGOGENERICOSUGERIDO VARCHAR(128), 
         SAP_DIGITADO                      VARCHAR(64), 
         DESCRIPCION_DIGITADO              VARCHAR(64), 
         ESTATUSSAP                        VARCHAR(64), 
         TIPOPRODUCTO                      VARCHAR(64), 
         TIPOPRODUCTOSUGERIDO              VARCHAR(64), 
         ESTATUSSAPSUGERIDO                VARCHAR(64), 
         SAP_SUGERIDO                      VARCHAR(64), 
         DESCRIPCION_SUGERIDO              VARCHAR(64) 
      ) 

    SET @ISOPAIS =(SELECT CODIGOISO 
                   FROM   PAIS 
                   WHERE  ESTADOACTIVO = 1) 

    INSERT INTO @TB_RESULTADOS_DIGITADOS_PEDIDO 
    SELECT @ISOPAIS                                                   PAIS, 
           P.CAMPANIAID                                               CAMPANIAID 
           , 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                           CONSULTORA 
           , 
           R.DESCRIPCION 
           REGION, 
           Z.NOMBRE                                                   ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT)  EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                            MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                        CATEGORIA, 
           PD.CANTIDAD, 
           ISNULL(PDF.CANTIDAD, 0) 
           CANTIDADFACTURO, 
           CASE 
             WHEN ESSUGERIDO = 0 THEN 'NO' 
             WHEN ESSUGERIDO = 1 THEN 'SI' 
             ELSE '' 
           END 
           ACEPTOSUGERIDO 
           , 
           COALESCE(CONVERT(VARCHAR(10), PF.FECHAFACTURADO, 103), '') 
           FECHAFACTURADO, 
           PS.ESTADO, 
           P.PEDIDOID, 
           P.IPUSUARIO, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END 
           ESBRILLANTE, 
           EA.DESCRIPCION 
           ESTADOACTIVIDAD, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO 
           , 
           ISNULL(PD.ORIGENPEDIDOWEB, '') 
           CODIGOFORMAVENTA, 
           ISNULL(OP.DESORIGENPEDIDOWEB, '') 
           DESCRIPCIONFORMAVENTA, 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC 
           CUCDIGITADO, 
           SP.DESCRIPCIONCUC 
           DESCRIPCIONCUCDIGITADO, 
           SP.CODIGOGENERICO 
           CODIGOGENERICODIGITADO, 
           SP.DESCRIPCIONGENERICO 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           PC1.CODIGOPRODUCTO 
           SAP_DIGITADO, 
           PC1.DESCRIPCION 
           DESCRIPCION_DIGITADO, 
           SP.CODIGOSTATUS                                            ESTATUSSAP 
           , 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           PS.CUVSUGERIDO 
    FROM   PEDIDOWEB P WITH (NOLOCK) 
           INNER JOIN PEDIDOWEBDETALLE PD WITH (NOLOCK) 
                   ON PD.PEDIDOID = P.PEDIDOID 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = P.CONSULTORAID 
           INNER JOIN ODS.CAMPANIA CA WITH (NOLOCK) 
                   ON CA.CODIGO = P.CAMPANIAID 
                      AND CA.CODIGO = PD.CAMPANIAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN PRODUCTOSUGERIDO PS WITH (NOLOCK) 
                   ON PS.CAMPANIAID = P.CAMPANIAID 
                      AND PS.CAMPANIAID = PD.CAMPANIAID 
                      AND PS.CUVSUGERIDO = PD.CUV 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DR WITH (NOLOCK) 
                   ON DR.CAMPANIAID = P.CAMPANIAID 
                      AND DR.CAMPANIAID = PD.CAMPANIAID 
                      AND DR.CONSULTORAID = C.CONSULTORAID 
                      AND DR.CUVSUGERIDO = PS.CUVSUGERIDO 
                      AND DR.CUVORIGINAL = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = P.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = PD.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           LEFT JOIN ODS.PEDIDO PF WITH (NOLOCK) 
                  ON PF.CAMPANIAID = CA.CAMPANIAID 
                     AND PF.CONSULTORAID = C.CONSULTORAID 
           LEFT JOIN ODS.PEDIDODETALLE PDF WITH (NOLOCK) 
                  ON PF.PEDIDOID = PDF.PEDIDOID 
                     AND PDF.CAMPANIAID = CA.CAMPANIAID 
                     AND PDF.CUV = PS.CUVSUGERIDO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
           LEFT JOIN ORIGENPEDIDOWEB OP 
                  ON OP.ORIGENPEDIDOWEBID = PD.ORIGENPEDIDOWEB 
    WHERE  P.CAMPANIAID IN (SELECT VALOR 
                            FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PD.ESSUGERIDO = 1 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT DIGITADO.PAIS, 
           DIGITADO.CAMPANIA, 
           DIGITADO.CONSULTORAID, 
           DIGITADO.CODIGOCONSULTORA, 
           DIGITADO.CONSULTORA, 
           DIGITADO.REGION, 
           DIGITADO.ZONA, 
           DIGITADO.EDAD, 
           DIGITADO.PRODUCTODIGITADO, 
           DIGITADO.MARCA, 
           DIGITADO.CATEGORIA, 
           CONCAT(DIGITADO.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA                                 MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           DIGITADO.CANTIDAD, 
           DIGITADO.CANTIDADFACTURO, 
           DIGITADO.ACEPTOSUGERIDO, 
           DIGITADO.FECHAFACTURADO, 
           DIGITADO.ESTADOSUGERIDO, 
           DIGITADO.PEDIDOID, 
           DIGITADO.IPUSUARIO, 
           DIGITADO.CODIGOSTATUS, 
           DIGITADO.DESCRIPCIONTIPODIGITADO, 
           DIGITADO.ESBRILLANTE, 
           DIGITADO.ESTADOACTIVIDAD, 
           ST2.DESCRIPCIONTIPO, 
           DIGITADO.PRECIODIGITADO, 
           PC2.PRECIOUNITARIO                                   PRECIOSUGERIDO, 
           DIGITADO.CODIGOFORMAVENTA, 
           DIGITADO.DESCRIPCIONFORMAVENTA, 
           DIGITADO.CODIGOTIPOOFERTA, 
           DIGITADO.DESCRIPCIONTIPOOFERTA, 
           DIGITADO.CUCDIGITADO, 
           DIGITADO.DESCRIPCIONCUCDIGITADO, 
           DIGITADO.CODIGOGENERICODIGITADO, 
           DIGITADO.DESCRIPCIONCODIGOGENERICODIGITADO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           DIGITADO.SAP_DIGITADO, 
           DIGITADO.DESCRIPCION_DIGITADO, 
           DIGITADO.ESTATUSSAP, 
           DIGITADO.TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO 
           , 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO                                   [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   @TB_RESULTADOS_DIGITADOS_PEDIDO DIGITADO 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = DIGITADO.CAMPANIA 
                      AND PC2.CUV = DIGITADO.CUVSUGERIDO 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 

    INSERT INTO @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    SELECT @ISOPAIS                                                  PAIS, 
           PS.CAMPANIAID, 
           C.CONSULTORAID, 
           C.CODIGO, 
           C.NOMBRECOMPLETO                                          CONSULTORA, 
           R.DESCRIPCION                                             REGION, 
           Z.NOMBRE                                                  ZONA, 
           CAST(DATEDIFF(YEAR, C.FECHANACIMIENTO, GETDATE()) AS INT) EDAD, 
           CONCAT(PS.CUV, ' - ', PC1.DESCRIPCION) 
           [PRODUCTO DIGITADO], 
           ISNULL(SM.DESCRIPCIONLARGA, '')                           MARCA, 
           ISNULL(SC.DESCRIPCIONCATEGORIA, '')                       CATEGORIA, 
           CONCAT(PS.CUVSUGERIDO, ' - ', PC2.DESCRIPCION) 
           [PRODUCTO SUGERIDO], 
           SM2.DESCRIPCIONLARGA 
           MARCASUGERIDO, 
           SC2.DESCRIPCIONCATEGORIA 
           CATEGORIASUGERIDO, 
           0                                                         CANTIDAD, 
           0 
           CANTIDADFACTURO 
           , 
           'NO' 
           ACEPTOSUGERIDO, 
           '' 
           FECHAFACTURADO, 
           PS.ESTADO, 
           0                                                         PEDIDOID, 
           0, 
           SP.CODIGOSTATUS, 
           ST.DESCRIPCIONTIPO, 
           CASE 
             WHEN C.ESBRILLANTE = 1 THEN 'BRILLA' 
             ELSE 'NO BRILLA' 
           END                                                       ESBRILLANTE 
           , 
           EA.DESCRIPCION, 
           ST2.DESCRIPCIONTIPO, 
           PC1.PRECIOUNITARIO 
           PRECIODIGITADO, 
           PC2.PRECIOUNITARIO 
           PRECIOSUGERIDO, 
           '', 
           '', 
           PC1.CODIGOTIPOOFERTA, 
           '' 
           DESCRIPCIONTIPOOFERTA, 
           SP.CUC, 
           SP.DESCRIPCIONCUC, 
           SP.CODIGOGENERICO, 
           SP.DESCRIPCIONGENERICO, 
           SP2.CUC, 
           SP2.DESCRIPCIONCUC, 
           SP2.CODIGOGENERICO, 
           SP2.DESCRIPCIONGENERICO, 
           PC1.CODIGOPRODUCTO 
           [SAP DIGITADO], 
           PC1.DESCRIPCION 
           [DESCRIPCION DIGITADO], 
           SP.CODIGOSTATUS                                           ESTATUSSAP, 
           ST.DESCRIPCIONTIPO 
           TIPOPRODUCTO, 
           ST2.DESCRIPCIONTIPO 
           TIPOPRODUCTOSUGERIDO, 
           SP2.CODIGOSTATUS, 
           PC2.CODIGOPRODUCTO 
           [SAP SUGERIDO], 
           PC2.DESCRIPCION 
           [DESCRIPCION SUGERIDO] 
    FROM   PRODUCTOSUGERIDO PS WITH (NOLOCK) 
           INNER JOIN DEMANDATOTALREEMPLAZOSUGERIDO DT WITH (NOLOCK) 
                   ON DT.CAMPANIAID = PS.CAMPANIAID 
                      AND PS.CUV = DT.CUVORIGINAL 
           INNER JOIN ODS.CONSULTORA C WITH (NOLOCK) 
                   ON C.CONSULTORAID = DT.CONSULTORAID 
           INNER JOIN ODS.ZONA Z WITH (NOLOCK) 
                   ON C.ZONAID = Z.ZONAID 
           INNER JOIN ODS.REGION R WITH (NOLOCK) 
                   ON Z. REGIONID = R.REGIONID 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC1 WITH (NOLOCK) 
                   ON PC1.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC1.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC1.CUV = PS.CUV 
           INNER JOIN ODS.PRODUCTOCOMERCIAL PC2 WITH (NOLOCK) 
                   ON PC2.ANOCAMPANIA = PS.CAMPANIAID 
                      AND PC2.ANOCAMPANIA = DT.CAMPANIAID 
                      AND PC2.CUV = PS.CUVSUGERIDO 
           /**** PRODUCTO DIGITADO *****/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP WITH (NOLOCK) 
                  ON PC1.CODIGOPRODUCTO = SP.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST WITH (NOLOCK) 
                  ON SP.CODIGOTIPO = ST.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC WITH (NOLOCK) 
                  ON SP.CODIGOCATEGORIA = SC.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM WITH (NOLOCK) 
                  ON SP.CODIGOMARCA = SM.CODIGO 
           /***** PRODUCTO SUGERIDO ******/ 
           LEFT JOIN ODS.SAP_PRODUCTO SP2 WITH (NOLOCK) 
                  ON PC2.CODIGOPRODUCTO = SP2.CODIGOSAP 
           LEFT JOIN ODS.SAP_TIPO ST2 WITH (NOLOCK) 
                  ON SP2.CODIGOTIPO = ST2.CODIGOTIPO 
           LEFT JOIN ODS.SAP_CATEGORIA SC2 WITH (NOLOCK) 
                  ON SP2.CODIGOCATEGORIA = SC2.CODIGOCATEGORIA 
           LEFT JOIN ODS.SAP_MARCA SM2 WITH (NOLOCK) 
                  ON SP2.CODIGOMARCA = SM2.CODIGO 
           INNER JOIN ODS.ESTADOACTIVIDAD EA 
                   ON EA.IDESTADOACTIVIDAD = C.IDESTADOACTIVIDAD 
    --LEFT JOIN ORIGENPEDIDOWEB OP ON OP.ORIGENPEDIDOWEBID=PD.ORIGENPEDIDOWEB  
    WHERE  PS.CAMPANIAID IN (SELECT VALOR 
                             FROM   DBO.SPLIT(@LISTCAMPANIAS, ',')) 
           AND PS.ESTADO = 1 /*VALIDA SI EL SUGERIDO ESTÀ ACTIVO O NO*/ 
           AND DT.CONSULTORAID IN (SELECT CONSULTORAID 
                                   FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
                                   GROUP  BY CONSULTORAID) 
           AND DT.CUVSUGERIDO IS NULL 

    SELECT PAIS, 
           CAST(CAMPANIA AS INT)                         CAMPANIAID, 
           CODIGOCONSULTORA                              CODIGO, 
           CONSULTORA, 
           CONSULTORAID, 
           PEDIDOID, 
           ISNULL(REGION, '')                            REGION, 
           ISNULL(ZONA, '')                              ZONA, 
           ISNULL(IPUSUARIO, '')                         IPUSUARIO, 
           ESBRILLANTE, 
           ISNULL(ESTADOACTIVIDAD, '')                   ESTADOACTIVIDAD, 
           EDAD, 
           ISNULL(CODIGOFORMAVENTA, '')                  CODIGOFORMAVENTA, 
           ISNULL(DESCRIPCIONFORMAVENTA, '')             DESCRIPCIONFORMAVENTA, 
           ISNULL(CODIGOTIPOOFERTA, '')                  CODIGOTIPOOFERTA, 
           ISNULL(DESCRIPCIONTIPOOFERTA, '')             DESCRIPCIONTIPOOFERTA, 
           ISNULL(CUCDIGITADO, '')                       CUCDIGITADO, 
           ISNULL(DESCRIPCIONCUCDIGITADO, '')            DESCRIPCIONCUCDIGITADO, 
           ISNULL(CODIGOGENERICODIGITADO, '')            CODIGOGENERICODIGITADO, 
           ISNULL(DESCRIPCIONCODIGOGENERICODIGITADO, '') 
           DESCRIPCIONCODIGOGENERICODIGITADO, 
           ISNULL(PRODUCTODIGITADO, '')                  PRODUCTO_DIGITADO, 
           ISNULL(SAP_DIGITADO, '')                      SAP_DIGITADO, 
           ISNULL(DESCRIPCION_DIGITADO, '')              DESCRIPCION_DIGITADO, 
           ISNULL(ESTATUSSAP, '')                        ESTATUSSAP, 
           ISNULL(MARCA, '')                             MARCA, 
           ISNULL(CATEGORIA, '')                         CATEGORIA, 
           ISNULL(TIPOPRODUCTO, '')                      TIPOPRODUCTO, 
           ISNULL(CUCSUGERIDO, '')                       CUCSUGERIDO, 
           ISNULL(DESCRIPCIONCUCSUGERIDO, '')            DESCRIPCIONCUCSUGERIDO, 
           ISNULL(CODIGOGENERICOSUGERIDO, '')            CODIGOGENERICOSUGERIDO, 
           ISNULL(DESCRIPCIONCODIGOGENERICOSUGERIDO, '') 
           DESCRIPCIONCODIGOGENERICOSUGERIDO, 
           ISNULL(PRODUCTOSUGERIDO, '')                  PRODUCTOSUGERIDO, 
           ISNULL(DESCRIPCION_SUGERIDO, '')              DESCRIPCION_SUGERIDO, 
           ISNULL(SAP_SUGERIDO, '')                      SAP_SUGERIDO, 
           ISNULL(MARCASUGERIDO, '')                     MARCASUGERIDO, 
           ISNULL(CATEGORIASUGERIDO, '')                 CATEGORIASUGERIDO, 
           ISNULL(TIPOPRODUCTOSUGERIDO, '')              TIPOPRODUCTOSUGERIDO, 
           CANTIDAD, 
           CANTIDADFACTURO, 
           PRECIODIGITADO, 
           PRECIOSUGERIDO, 
           ACEPTOSUGERIDO                                ACEPTOPRODUCTOSUGERIDO, 
           ISNULL(FECHAFACTURADO, '')                    FECHAFACTURADO, 
           ISNULL(ESTATUSSAPSUGERIDO, '')                ESTATUSSAPSUGERIDO 
    -- ID CODREN 
    FROM   @TB_RESULTADOS_SUGERIDOS_PEDIDO 
    GROUP  BY PAIS, 
              CAMPANIA, 
              CODIGOCONSULTORA, 
              CONSULTORA, 
              CONSULTORAID, 
              PEDIDOID, 
              REGION, 
              ZONA, 
              IPUSUARIO, 
              ESBRILLANTE, 
              ESTADOACTIVIDAD, 
              EDAD, 
              CODIGOFORMAVENTA, 
              DESCRIPCIONFORMAVENTA, 
              CODIGOTIPOOFERTA, 
              DESCRIPCIONTIPOOFERTA, 
              CUCDIGITADO, 
              DESCRIPCIONCUCDIGITADO, 
              CODIGOGENERICODIGITADO, 
              DESCRIPCIONCODIGOGENERICODIGITADO, 
              PRODUCTODIGITADO, 
              SAP_DIGITADO, 
              DESCRIPCION_DIGITADO, 
              ESTATUSSAP, 
              MARCA, 
              CATEGORIA, 
              TIPOPRODUCTO, 
              CUCSUGERIDO, 
              DESCRIPCIONCUCSUGERIDO, 
              CODIGOGENERICOSUGERIDO, 
              DESCRIPCIONCODIGOGENERICOSUGERIDO, 
              PRODUCTOSUGERIDO, 
              DESCRIPCION_SUGERIDO, 
              SAP_SUGERIDO, 
              MARCASUGERIDO, 
              CATEGORIASUGERIDO, 
              TIPOPRODUCTOSUGERIDO, 
              CANTIDAD, 
              CANTIDADFACTURO, 
              PRECIODIGITADO, 
              PRECIOSUGERIDO, 
              ACEPTOSUGERIDO, 
              FECHAFACTURADO, 
              ESTATUSSAPSUGERIDO 
-- ID  
END 

GO
